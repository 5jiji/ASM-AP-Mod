from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import CollectionState, Region

if TYPE_CHECKING:
    from .world import ASMWorld

REGION_NAMES = [
    "babataire","babaex","eldritch","alchemy","wolf","poker","big","lock","thing","cheat","single","binary","limited","random","swap","hanoi","fork","solitairdle","stack","tear","fiftytwo","time","garden","solar","doubleside","murder","elec","quant","key","river"
]

def create_and_connect_regions(world: ASMWorld) -> None:
    create_all_regions(world)
    connect_regions(world)

def create_all_regions(world: ASMWorld) -> None:
    regions = []
    regions.append(Region("Menu", world.player, world.multiworld))

    for name in REGION_NAMES:
        regions.append(Region(name, world.player, world.multiworld))

    world.multiworld.regions += regions

def connect_regions(world: ASMWorld) -> None:
    menu = world.get_region("Menu")
    for name in REGION_NAMES:
        menu.connect(world.get_region(name))
