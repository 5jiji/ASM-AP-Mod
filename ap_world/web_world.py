from BaseClasses import Tutorial
from worlds.AutoWorld import WebWorld

from .options import option_groups, option_presets

class ASMWebWorld(WebWorld):
    game = "A Solitaire Mystery"
    theme = "stone"

    setup_en = Tutorial(
        "Multiworld Setup Guide",
        "A guide to setting up A Solitaire Mystery for MultiWorld.",
        "English",
        "setup_en.md",
        "setup/en",
        ["5jiji"],
    )

    tutorials = [setup_en]

    option_groups = option_groups
    options_presets = option_presets
