from test.bases import WorldTestBase
from worlds.ASM import ASMWorld


class ASMTestBase(WorldTestBase):
    game = "A Solitaire Mystery"
    world: ASMWorld