from __future__ import annotations

from typing import TYPE_CHECKING

from worlds.ASM.regions import REGION_NAMES
from worlds.generic.Rules import set_rule

if TYPE_CHECKING:
    from .world import ASMWorld

def set_all_rules(world: ASMWorld) -> None:
    set_region_rules(world)
    set_completion_condition(world)

    #gen_graph(world)

def set_region_rules(world: ASMWorld) -> None:
    for name in REGION_NAMES:
        entrance = world.get_entrance(f"Menu -> {name}")

        item_names_in_pool = get_item_names_in_pool(world)

        if name in item_names_in_pool:
            set_rule(entrance, lambda state, name=name: state.has(name, world.player))
        else:
            set_rule(entrance, lambda state: True)

def get_item_names_in_pool(world: ASMWorld):
    item_names = []
    for item in world.multiworld.itempool:
        item_names.append(item.name)

    return item_names

def set_completion_condition(world: ASMWorld) -> None:
    world.multiworld.completion_condition[world.player] = lambda state: state.has("Victory", world.player)

def gen_graph(world: ASMWorld):
    from Utils import visualize_regions
    visualize_regions(world.multiworld.get_region("Menu", world.player), "my_world.puml", )
