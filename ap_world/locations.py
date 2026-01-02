from __future__ import annotations

from typing import TYPE_CHECKING, List

from BaseClasses import CollectionState, Location, LocationProgressType
from worlds.ASM.rules import REGION_NAMES

if TYPE_CHECKING:
    from .world import ASMWorld

LOCATION_NAME_TO_ID = {
    "babataire-win_1": 1,
    "babataire-win_5": 2,
    "babataire-win_10": 3,
    "babataire-streak_2": 4,
    "babaex-win_1": 5,
    "babaex-win_5": 6,
    "babaex-win_10": 7,
    "babaex-streak_2": 8,
    "eldritch-win_1": 9,
    "eldritch-win_5": 10,
    "eldritch-win_10": 11,
    "eldritch-streak_2": 12,
    "alchemy-win_1": 13,
    "alchemy-win_5": 14,
    "alchemy-win_10": 15,
    "alchemy-streak_2": 16,
    "wolf-win_1": 17,
    "wolf-win_5": 18,
    "wolf-win_10": 19,
    "wolf-streak_2": 20,
    "poker-win_1": 21,
    "poker-win_5": 22,
    "poker-win_10": 23,
    "poker-streak_2": 24,
    "big-win_1": 25,
    "big-win_5": 26,
    "big-win_10": 27,
    "big-streak_2": 28,
    "lock-win_1": 29,
    "lock-win_5": 30,
    "lock-win_10": 31,
    "lock-streak_2": 32,
    "thing-win_1": 33,
    "thing-win_5": 34,
    "thing-win_10": 35,
    "thing-streak_2": 36,
    "cheat-win_1": 37,
    "cheat-win_5": 38,
    "cheat-win_10": 39,
    "cheat-streak_2": 40,
    "single-win_1": 41,
    "single-win_5": 42,
    "single-win_10": 43,
    "single-streak_2": 44,
    "binary-win_1": 45,
    "binary-win_5": 46,
    "binary-win_10": 47,
    "binary-streak_2": 48,
    "limited-win_1": 49,
    "limited-win_5": 50,
    "limited-win_10": 51,
    "limited-streak_2": 52,
    "random-win_1": 53,
    "random-win_5": 54,
    "random-win_10": 55,
    "random-streak_2": 56,
    "swap-win_1": 57,
    "swap-win_5": 58,
    "swap-win_10": 59,
    "swap-streak_2": 60,
    "hanoi-win_1": 61,
    "hanoi-win_5": 62,
    "hanoi-win_10": 63,
    "hanoi-streak_2": 64,
    "fork-win_1": 65,
    "fork-win_5": 66,
    "fork-win_10": 67,
    "fork-streak_2": 68,
    "solitairdle-win_1": 69,
    "solitairdle-win_5": 70,
    "solitairdle-win_10": 71,
    "solitairdle-streak_2": 72,
    "stack-win_1": 73,
    "stack-win_5": 74,
    "stack-win_10": 75,
    "stack-streak_2": 76,
    "tear-win_1": 77,
    "tear-win_5": 78,
    "tear-win_10": 79,
    "tear-streak_2": 80,
    "fiftytwo-win_1": 81,
    "fiftytwo-win_5": 82,
    "fiftytwo-win_10": 83,
    "fiftytwo-streak_2": 84,
    "time-win_1": 85,
    "time-win_5": 86,
    "time-win_10": 87,
    "time-streak_2": 88,
    "garden-win_1": 89,
    "garden-win_5": 90,
    "garden-win_10": 91,
    "garden-streak_2": 92,
    "solar-win_1": 93,
    "solar-win_5": 94,
    "solar-win_10": 95,
    "solar-streak_2": 96,
    "doubleside-win_1": 97,
    "doubleside-win_5": 98,
    "doubleside-win_10": 99,
    "doubleside-streak_2": 100,
    "murder-win_1": 101,
    "murder-win_5": 102,
    "murder-win_10": 103,
    "murder-streak_2": 104,
    "elec-win_1": 105,
    "elec-win_5": 106,
    "elec-win_10": 107,
    "elec-streak_2": 108,
    "quant-win_1": 109,
    "quant-win_5": 110,
    "quant-win_10": 111,
    "quant-streak_2": 112,
    "key-win_1": 113,
    "key-win_5": 114,
    "key-win_10": 115,
    "key-streak_2": 116,
    "river-win_1": 117,
    "river-win_5": 118,
    "river-win_10": 119,
    "river-streak_2": 120,
}

class ASMLocation(Location):
    game = "A Solitaire Mystery"

def get_location_names_with_ids(location_names: list[str]) -> dict[str, int | None]:
    return {location_name: LOCATION_NAME_TO_ID[location_name] for location_name in location_names}

def create_all_locations(world: ASMWorld) -> None:
    create_regular_locations(world)
    create_events(world)

def create_regular_locations(world: ASMWorld) -> None:
    for name in LOCATION_NAME_TO_ID:
        [region_name, prize] = name.split("-")
        region = world.get_region(region_name)
        location = ASMLocation(world.player, name, world.location_name_to_id[name], region)
        region.locations.append(location)

        if prize == "win_1" or prize == "streak_2":
            location.progress_type = LocationProgressType.PRIORITY
        elif not world.options.win_5 and prize == "win_5":
            location.progress_type = LocationProgressType.EXCLUDED
        elif not world.options.win_10 and prize == "win_10":
            location.progress_type = LocationProgressType.EXCLUDED

def create_events(world: ASMWorld) -> None:
    menu = world.get_region("Menu")

    locations = get_final_mode_locations(world)

    menu.add_event(f"Finish {world.options.finished_modes.value} modes", "Victory", lambda state, locations=locations: win_rule(state, world, locations))

def win_rule(state: CollectionState, world: ASMWorld, locations: List[str]) -> bool:
    count = 0
    for location in locations:
        if state.can_reach_location(location, world.player):
            count += 1

    return count >= world.options.finished_modes.value

def get_final_mode_locations(world: ASMWorld) -> List[str]:
    suffix = "win_1"
    if world.options.win_5:
        if world.options.win_10:
            suffix = "win_10"
        else:
            suffix = "win_5"

    return [f"{region}-{suffix}" for region in REGION_NAMES]
