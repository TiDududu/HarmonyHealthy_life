// tabId
export var TabId;
(function (TabId) {
    TabId[TabId["HOME"] = 0] = "HOME";
    TabId[TabId["ACHIEVEMENT"] = 1] = "ACHIEVEMENT";
    TabId[TabId["MINE"] = 2] = "MINE";
})(TabId || (TabId = {}));
export const NavList = [
    {
        icon: { "id": 16777382, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        icon_selected: { "id": 16777383, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        text: { "id": 16777252, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        id: TabId.HOME
    },
    {
        icon: { "id": 16777380, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        icon_selected: { "id": 16777381, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        text: { "id": 16777251, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        id: TabId.ACHIEVEMENT
    },
    {
        icon: { "id": 16777384, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        icon_selected: { "id": 16777385, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        text: { "id": 16777253, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
        id: TabId.MINE
    },
];
//# sourceMappingURL=NavItemModel.js.map