from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import CollectionState, Region

if TYPE_CHECKING:
    from .world import ASMWorld

# A region is a container for locations ("checks"), which connects to other regions via "Entrance" objects.
# Many games will model their Regions after physical in-game places, but you can also have more abstract regions.
# For a location to be in logic, its containing region must be reachable.
# The Entrances connecting regions can have rules - more on that in rules.py.
# This makes regions especially useful for traversal logic ("Can the player reach this part of the map?")

# Every location must be inside a region, and you must have at least one region.
# This is why we create regions first, and then later we create the locations (in locations.py).

REGION_NAMES = [
    "babataire","babaex","eldritch","alchemy","wolf","poker","big","lock","thing","cheat","single","binary","limited","random","swap","hanoi","fork","solitairdle","stack","tear","fiftytwo","time","garden","solar","doubleside","murder","elec","quant","key","river"
]

def create_and_connect_regions(world: ASMWorld) -> None:
    create_all_regions(world)
    connect_regions(world)


def create_all_regions(world: ASMWorld) -> None:
    # Creating a region is as simple as calling the constructor of the Region class.
    regions = []
    regions.append(Region("Menu", world.player, world.multiworld))

    for name in REGION_NAMES:
        regions.append(Region(name, world.player, world.multiworld))

    # We now need to add these regions to multiworld.regions so that AP knows about their existence.
    world.multiworld.regions += regions


def connect_regions(world: ASMWorld) -> None:
    menu = world.get_region("Menu")
    for name in REGION_NAMES:
        menu.connect(world.get_region(name))
