from __future__ import annotations

from typing import TYPE_CHECKING, List

from BaseClasses import CollectionState, Location, LocationProgressType
from worlds.ASM.rules import REGION_NAMES

if TYPE_CHECKING:
    from .world import ASMWorld

LOCATION_NAME_TO_ID = {
    "Tap Solitaire - Win 1": 1,
    "Tap Solitaire - Win 5": 2,
    "Tap Solitaire - Win 10": 3,
    "Tap Solitaire - Streak 2": 4,
    "Babataire - Win 1": 5,
    "Babataire - Win 5": 6,
    "Babataire - Win 10": 7,
    "Babataire - Streak 2": 8,
    "Eldritch Invasion - Win 1": 9,
    "Eldritch Invasion - Win 5": 10,
    "Eldritch Invasion - Win 10": 11,
    "Eldritch Invasion - Streak 2": 12,
    "Transmutation - Win 1": 13,
    "Transmutation - Win 5": 14,
    "Transmutation - Win 10": 15,
    "Transmutation - Streak 2": 16,
    "Council of Secrets - Win 1": 17,
    "Council of Secrets - Win 5": 18,
    "Council of Secrets - Win 10": 19,
    "Council of Secrets - Streak 2": 20,
    "Royal Flush Solitaire - Win 1": 21,
    "Royal Flush Solitaire - Win 5": 22,
    "Royal Flush Solitaire - Win 10": 23,
    "Royal Flush Solitaire - Streak 2": 24,
    "Megataire - Win 1": 25,
    "Megataire - Win 5": 26,
    "Megataire - Win 10": 27,
    "Megataire - Streak 2": 28,
    "Lock Solitaire - Win 1": 29,
    "Lock Solitaire - Win 5": 30,
    "Lock Solitaire - Win 10": 31,
    "Lock Solitaire - Streak 2": 32,
    "Uneven Solitaire - Win 1": 33,
    "Uneven Solitaire - Win 5": 34,
    "Uneven Solitaire - Win 10": 35,
    "Uneven Solitaire - Streak 2": 36,
    "Cheatdeck Solitaire - Win 1": 37,
    "Cheatdeck Solitaire - Win 5": 38,
    "Cheatdeck Solitaire - Win 10": 39,
    "Cheatdeck Solitaire - Streak 2": 40,
    "Single-card Solitaire - Win 1": 41,
    "Single-card Solitaire - Win 5": 42,
    "Single-card Solitaire - Win 10": 43,
    "Single-card Solitaire - Streak 2": 44,
    "Binary Solitaire - Win 1": 45,
    "Binary Solitaire - Win 5": 46,
    "Binary Solitaire - Win 10": 47,
    "Binary Solitaire - Streak 2": 48,
    "Limited Move Solitaire - Win 1": 49,
    "Limited Move Solitaire - Win 5": 50,
    "Limited Move Solitaire - Win 10": 51,
    "Limited Move Solitaire - Streak 2": 52,
    "Chaotic Solitaire - Win 1": 53,
    "Chaotic Solitaire - Win 5": 54,
    "Chaotic Solitaire - Win 10": 55,
    "Chaotic Solitaire - Streak 2": 56,
    "Swap-a-taire - Win 1": 57,
    "Swap-a-taire - Win 5": 58,
    "Swap-a-taire - Win 10": 59,
    "Swap-a-taire - Streak 2": 60,
    "Hanoi Solitaire - Win 1": 61,
    "Hanoi Solitaire - Win 5": 62,
    "Hanoi Solitaire - Win 10": 63,
    "Hanoi Solitaire - Streak 2": 64,
    "Fork Solitaire - Win 1": 65,
    "Fork Solitaire - Win 5": 66,
    "Fork Solitaire - Win 10": 67,
    "Fork Solitaire - Streak 2": 68,
    "Solitairdle - Win 1": 69,
    "Solitairdle - Win 5": 70,
    "Solitairdle - Win 10": 71,
    "Solitairdle - Streak 2": 72,
    "Single-stack Solitaire - Win 1": 73,
    "Single-stack Solitaire - Win 5": 74,
    "Single-stack Solitaire - Win 10": 75,
    "Single-stack Solitaire - Streak 2": 76,
    "Tear Solitaire - Win 1": 77,
    "Tear Solitaire - Win 5": 78,
    "Tear Solitaire - Win 10": 79,
    "Tear Solitaire - Streak 2": 80,
    "52-Card Solitaire - Win 1": 81,
    "52-Card Solitaire - Win 5": 82,
    "52-Card Solitaire - Win 10": 83,
    "52-Card Solitaire - Streak 2": 84,
    "Time Travel Solitaire - Win 1": 85,
    "Time Travel Solitaire - Win 5": 86,
    "Time Travel Solitaire - Win 10": 87,
    "Time Travel Solitaire - Streak 2": 88,
    "Garden Solitaire - Win 1": 89,
    "Garden Solitaire - Win 5": 90,
    "Garden Solitaire - Win 10": 91,
    "Garden Solitaire - Streak 2": 92,
    "Solartaire - Win 1": 93,
    "Solartaire - Win 5": 94,
    "Solartaire - Win 10": 95,
    "Solartaire - Streak 2": 96,
    "Double-sided Solitaire - Win 1": 97,
    "Double-sided Solitaire - Win 5": 98,
    "Double-sided Solitaire - Win 10": 99,
    "Double-sided Solitaire - Streak 2": 100,
    "Murder Mystery - Win 1": 101,
    "Murder Mystery - Win 5": 102,
    "Murder Mystery - Win 10": 103,
    "Murder Mystery - Streak 2": 104,
    "Circuit Solitaire - Win 1": 105,
    "Circuit Solitaire - Win 5": 106,
    "Circuit Solitaire - Win 10": 107,
    "Circuit Solitaire - Streak 2": 108,
    "Tabula Rasa Solitaire - Win 1": 109,
    "Tabula Rasa Solitaire - Win 5": 110,
    "Tabula Rasa Solitaire - Win 10": 111,
    "Tabula Rasa Solitaire - Streak 2": 112,
    "Lock-and-Key Solitaire - Win 1": 113,
    "Lock-and-Key Solitaire - Win 5": 114,
    "Lock-and-Key Solitaire - Win 10": 115,
    "Lock-and-Key Solitaire - Streak 2": 116,
    "Ferret Rabbit Carrot - Win 1": 117,
    "Ferret Rabbit Carrot - Win 5": 118,
    "Ferret Rabbit Carrot - Win 10": 119,
    "Ferret Rabbit Carrot - Streak 2": 120,
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
        [region_name, prize] = name.split(" - ")
        region = world.get_region(region_name)
        location = ASMLocation(world.player, name, world.location_name_to_id[name], region)
        region.locations.append(location)

        if prize == "Win 1" or prize == "Streak 2":
            location.progress_type = LocationProgressType.PRIORITY
        elif not world.options.win_5 and prize == "Win 5":
            location.progress_type = LocationProgressType.EXCLUDED
        elif not world.options.win_10 and prize == "Win 10":
            location.progress_type = LocationProgressType.EXCLUDED

def create_events(world: ASMWorld) -> None:
    menu = world.get_region("Menu")

    locations = get_final_mode_locations(world)

    menu.add_event(f"Finish {world.options.finished_modes.value} modes", "Victory", lambda state, locations=locations: victory_rule(state, world, locations))

def victory_rule(state: CollectionState, world: ASMWorld, locations: List[str]) -> bool:
    count = 0
    for location in locations:
        if state.can_reach_location(location, world.player):
            count += 1

    return count >= world.options.finished_modes.value

def get_final_mode_locations(world: ASMWorld) -> List[str]:
    suffix = "Win 1"
    if world.options.win_5:
        if world.options.win_10:
            suffix = "Win 10"
        else:
            suffix = "Win 5"

    return [f"{region} - {suffix}" for region in REGION_NAMES]
