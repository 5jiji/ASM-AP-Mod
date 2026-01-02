from .bases import ASMTestBase
from typing import List

class TestRules(ASMTestBase):
    def test_location_rules(self):
        precollected_item_names = self.get_precollected_names()

        for region in self.world.get_regions():
            if region.name == "Menu":
                continue
            if region.name in precollected_item_names:
                continue

            with self.subTest("Check if locations is only accessible with item of same name", name=region.name):
                item = region.name
                loc_prefix = region.name

                self.assertAccessDependency(
                    [loc_prefix + "-win_1", loc_prefix + "-win_5", loc_prefix + "-win_10", loc_prefix + "-streak_2"],
                    [[item]],
                    only_check_listed=True
                )

    def test_item_unlock_region(self):
        self.remove_by_name(self.world.item_id_to_name.values())

        precollected_item_names = self.get_precollected_names()

        for region in self.world.get_regions():
            if region.name == "Menu":
                continue

            with self.subTest("Check if item properly unlocks region of same name", item=region.name):
                item = region.name

                if item in precollected_item_names:
                    self.assertTrue(region.can_reach(self.multiworld.state), "Region can't be reached (supposed to be in starting inventory)")
                    continue
                
                self.assertFalse(region.can_reach(self.multiworld.state), "Region can be reached without item")

                self.collect_by_name(item)
                self.assertTrue(region.can_reach(self.multiworld.state), "Region cannot be reached with item")

                self.remove_by_name(item)

    def get_precollected_names(self) -> List[str]:
        names = []
        for item in self.world.multiworld.precollected_items[self.world.player]:
            names.append(item.name)
        
        return names
