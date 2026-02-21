from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Item, ItemClassification

if TYPE_CHECKING:
    from .world import ASMWorld

ITEM_NAME_TO_ID = {
    "Tap Solitaire": 1,
    "Babataire": 2,
    "Eldritch Invasion": 3,
    "Transmutation": 4,
    "Council of Secrets": 5,
    "Royal Flush Solitaire": 6,
    "Megataire": 7,
    "Lock Solitaire": 8,
    "Uneven Solitaire": 9,
    "Cheatdeck Solitaire": 10,
    "Single-card Solitaire": 11,
    "Binary Solitaire": 12,
    "Limited Move Solitaire": 13,
    "Chaotic Solitaire": 14,
    "Swap-a-taire": 15,
    "Hanoi Solitaire": 16,
    "Fork Solitaire": 17,
    "Solitairdle": 18,
    "Single-stack Solitaire": 19,
    "Tear Solitaire": 20,
    "52-Card Solitaire": 21,
    "Time Travel Solitaire": 22,
    "Garden Solitaire": 23,
    "Solartaire": 24,
    "Double-sided Solitaire": 25,
    "Murder Mystery": 26,
    "Circuit Solitaire": 27,
    "Tabula Rasa Solitaire": 28,
    "Lock-and-Key Solitaire": 29,
    "Ferret Rabbit Carrot": 30,

    # Traps
    "Undo Trap": 31,
}

NORMAL_ITEMS = [
    "Tap Solitaire",
    "Babataire",
    "Eldritch Invasion",
    "Transmutation",
    "Council of Secrets",
    "Royal Flush Solitaire",
    "Megataire",
    "Lock Solitaire",
    "Uneven Solitaire",
    "Cheatdeck Solitaire",
    "Single-card Solitaire",
    "Binary Solitaire",
    "Limited Move Solitaire",
    "Chaotic Solitaire",
    "Swap-a-taire",
    "Hanoi Solitaire",
    "Fork Solitaire",
    "Solitairdle",
    "Single-stack Solitaire",
    "Tear Solitaire",
    "52-Card Solitaire",
    "Time Travel Solitaire",
    "Garden Solitaire",
    "Solartaire",
    "Double-sided Solitaire",
    "Murder Mystery",
    "Circuit Solitaire",
    "Tabula Rasa Solitaire",
    "Lock-and-Key Solitaire",
    "Ferret Rabbit Carrot",
]

DEFAULT_ITEM_CLASSIFICATIONS = {
    "Tap Solitaire": ItemClassification.progression,
    "Babataire": ItemClassification.progression,
    "Eldritch Invasion": ItemClassification.progression,
    "Transmutation": ItemClassification.progression,
    "Council of Secrets": ItemClassification.progression,
    "Royal Flush Solitaire": ItemClassification.progression,
    "Megataire": ItemClassification.progression,
    "Lock Solitaire": ItemClassification.progression,
    "Uneven Solitaire": ItemClassification.progression,
    "Cheatdeck Solitaire": ItemClassification.progression,
    "Single-card Solitaire": ItemClassification.progression,
    "Binary Solitaire": ItemClassification.progression,
    "Limited Move Solitaire": ItemClassification.progression,
    "Chaotic Solitaire": ItemClassification.progression,
    "Swap-a-taire": ItemClassification.progression,
    "Hanoi Solitaire": ItemClassification.progression,
    "Fork Solitaire": ItemClassification.progression,
    "Solitairdle": ItemClassification.progression,
    "Single-stack Solitaire": ItemClassification.progression,
    "Tear Solitaire": ItemClassification.progression,
    "52-Card Solitaire": ItemClassification.progression,
    "Time Travel Solitaire": ItemClassification.progression,
    "Garden Solitaire": ItemClassification.progression,
    "Solartaire": ItemClassification.progression,
    "Double-sided Solitaire": ItemClassification.progression,
    "Murder Mystery": ItemClassification.progression,
    "Circuit Solitaire": ItemClassification.progression,
    "Tabula Rasa Solitaire": ItemClassification.progression,
    "Lock-and-Key Solitaire": ItemClassification.progression,
    "Ferret Rabbit Carrot": ItemClassification.progression,

    # Traps
    "Undo Trap": ItemClassification.trap,
}

class ASMItem(Item):
    game = "A Solitaire Mystery"

def get_random_filler_item_name(world: ASMWorld) -> str:
    if world.random.randint(0, 99) < world.options.trap_chance:
        return "Undo Trap"
    return "Nothing"

def create_item_with_correct_classification(world: ASMWorld, name: str) -> ASMItem:
    if name == "Nothing":
        return ASMItem(name, ItemClassification.filler, -1, world.player)
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
