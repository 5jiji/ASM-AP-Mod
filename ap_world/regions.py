from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import CollectionState, Region
from worlds.ASM.items import NORMAL_ITEMS

if TYPE_CHECKING:
    from .world import ASMWorld

REGION_NAMES = NORMAL_ITEMS

def create_and_connect_regions(world: ASMWorld) -> None:
    create_all_regions(world)
    connect_regions(world)

def create_all_regions(world: ASMWorld) -> None:
    regions = []
    regions.append(Region("Menu", world.player, world.multiworld))

    for name in NORMAL_ITEMS:
        regions.append(Region(name, world.player, world.multiworld))

    world.multiworld.regions += regions

def connect_regions(world: ASMWorld) -> None:
    menu = world.get_region("Menu")
    for name in NORMAL_ITEMS:
        menu.connect(world.get_region(name))
