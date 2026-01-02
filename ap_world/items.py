from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Item, ItemClassification

if TYPE_CHECKING:
    from .world import ASMWorld

ITEM_NAME_TO_ID = {
    "babataire": 1,
    "babaex": 2,
    "eldritch": 3,
    "alchemy": 4,
    "wolf": 5,
    "poker": 6,
    "big": 7,
    "lock": 8,
    "thing": 9,
    "cheat": 10,
    "single": 11,
    "binary": 12,
    "limited": 13,
    "random": 14,
    "swap": 15,
    "hanoi": 16,
    "fork": 17,
    "solitairdle": 18,
    "stack": 19,
    "tear": 20,
    "fiftytwo": 21,
    "time": 22,
    "garden": 23,
    "solar": 24,
    "doubleside": 25,
    "murder": 26,
    "elec": 27,
    "quant": 28,
    "key": 29,
    "river": 30,
    "nothing": 31,
    "no undo": 32,
}

NORMAL_ITEMS = [
    "babataire", "babaex", "eldritch", "alchemy", "wolf", "poker", "big", "lock", "thing", "cheat", "single", "binary", "limited", "random", "swap", "hanoi", "fork", "solitairdle", "stack", "tear", "fiftytwo", "time", "garden", "solar", "doubleside", "murder", "elec", "quant", "key", "river"
]

DEFAULT_ITEM_CLASSIFICATIONS = {
    "babataire": ItemClassification.progression,
    "babaex": ItemClassification.progression,
    "eldritch": ItemClassification.progression,
    "alchemy": ItemClassification.progression,
    "wolf": ItemClassification.progression,
    "poker": ItemClassification.progression,
    "big": ItemClassification.progression,
    "lock": ItemClassification.progression,
    "thing": ItemClassification.progression,
    "cheat": ItemClassification.progression,
    "single": ItemClassification.progression,
    "binary": ItemClassification.progression,
    "limited": ItemClassification.progression,
    "random": ItemClassification.progression,
    "swap": ItemClassification.progression,
    "hanoi": ItemClassification.progression,
    "fork": ItemClassification.progression,
    "solitairdle": ItemClassification.progression,
    "stack": ItemClassification.progression,
    "tear": ItemClassification.progression,
    "fiftytwo": ItemClassification.progression,
    "time": ItemClassification.progression,
    "garden": ItemClassification.progression,
    "solar": ItemClassification.progression,
    "doubleside": ItemClassification.progression,
    "murder": ItemClassification.progression,
    "elec": ItemClassification.progression,
    "quant": ItemClassification.progression,
    "key": ItemClassification.progression,
    "river": ItemClassification.progression,
    "nothing": ItemClassification.filler,
    "no undo": ItemClassification.trap,
}

class ASMItem(Item):
    game = "A Solitaire Mystery"

def get_random_filler_item_name(world: ASMWorld) -> str:
    if world.random.randint(0, 99) < world.options.trap_chance:
        return "no undo"
    return "nothing"

def create_item_with_correct_classification(world: ASMWorld, name: str) -> ASMItem:
    classification = DEFAULT_ITEM_CLASSIFICATIONS[name]
    return ASMItem(name, classification, ITEM_NAME_TO_ID[name], world.player)

def create_all_items(world: ASMWorld) -> None:
    itempool: list[Item] = [ world.create_item(NORMAL_ITEMS[i]) for i in range(len(NORMAL_ITEMS)) ]

    for _ in range(world.options.unlocked_modes):
        index = world.random.randint(0, len(itempool))
        item = itempool[index-1]
        world.push_precollected(item)
        itempool.remove(item)

    number_of_items = len(itempool)
    number_of_unfilled_locations = len(world.multiworld.get_unfilled_locations(world.player))

    needed_number_of_filler_items = number_of_unfilled_locations - number_of_items
    itempool += [world.create_filler() for _ in range(needed_number_of_filler_items)]

    world.multiworld.itempool += itempool    
