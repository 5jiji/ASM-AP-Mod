from dataclasses import dataclass

from Options import Choice, OptionGroup, PerGameCommonOptions, Range, Toggle

class UnlockedModes(Range):
    """
    How many random unlocked game modes by default.

    If you want to define before generation which modes are already unlocked,
    Set this setting to 0 and use the start inventory settings instead.
    """

    display_name = "Unlocked Modes"

    range_start = 0
    range_end = 30 # There is 30 game modes, which also means that no item will be pushed in the world if chosen

    default = 5 # To not bore the player

class TrapChance(Range):
    """
    The chance to get a trap instead of nothing.
    """

    display_name = "Trap Chance"

    range_start = 0
    range_end = 100
    default = 0

class FinishedModes(Range):
    """
    How many finished game modes for the game to be considered completed.
    """

    display_name = "Completed Modes"

    range_start = 2
    range_end = 30

    default = 15

class Win10(Toggle):
    """
    If a progression item can be found when getting 10 wins on a mode
    """

    display_name = "10 Win Required"

class Win5(Toggle):
    """
    If a progression item can be found when getting 5 wins on a mode
    """

    display_name = "5 Win Required"

class DeathLink(Toggle):
    """
    Enabled DeathLink for A Solitaire Mystery
    
    A restart is considered as a death, same as quitting.
    """

    display_name = "DeathLink"

@dataclass
class ASMOptions(PerGameCommonOptions):
    unlocked_modes: UnlockedModes
    trap_chance: TrapChance
    finished_modes: FinishedModes
    win_10: Win10
    win_5: Win5
    death_link: DeathLink

option_groups = [
    OptionGroup(
        "Gameplay Options",
        [UnlockedModes, TrapChance, FinishedModes, Win10, Win5, DeathLink],
    ),
]

option_presets = {
    "default": {
        "unlocked_modes": 5,
        "trap_chance": 0,
        "finished_modes": 10,
        "win_10": False,
        "win_5": False,
        "death_link": False,
    },
    "I hate u": {
        "unlocked_modes": 0,
        "trap_change": 100,
        "finished_modes": 30,
        "win_10": True,
        "win_5": True,
        "death_link": True,
    }
}
