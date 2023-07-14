"use strict";
/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
let agencyStorage = new LocalStorage();
class AgencyCard extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__taskList = this.createLocalStorageProp("taskList", [], "taskList");
        this.__showWidget = this.createLocalStorageProp("showWidget", false, "showWidget");
        this.iconList = {
            getup: { "id": 16777263, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
            drink: { "id": 16777264, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
            apple: { "id": 16777252, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
            smile: { "id": 16777271, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
            clean: { "id": 16777258, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
            sleep: { "id": 16777373, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" }
        };
        this.ACTION_TYPE = 'router';
        this.ABILITY_NAME = 'EntryAbility';
        this.FULL_WIDTH_PERCENT = '100%';
        this.FULL_HEIGHT_PERCENT = '100%';
        this.EMPTY_IMAGE_WIDTH = '31%';
        this.AGENCY_COMPONENT_HEIGHT = '31%';
        this.EMPTY_IMAGE_HEIGHT = '51%';
        this.TEXT_MARGIN_TOP = '0.5%';
        this.CROSS_BAR_SYMBOL = '--';
        this.SLASHES = '/';
        this.TARGET_VALUE_SPLICING = this.CROSS_BAR_SYMBOL + this.SLASHES;
        this.LIST_SPACE = 5;
        this.LIST_TWO_LANES = 2;
        this.TEXT_OPACITY = 0.4;
        this.TARGET_TEXT_OPACITY = 0.6;
        this.TARGET_TEXT_WEIGHT = 1;
        this.TEXT_SLIGHTLY_BOLD = 500;
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.iconList !== undefined) {
            this.iconList = params.iconList;
        }
        if (params.ACTION_TYPE !== undefined) {
            this.ACTION_TYPE = params.ACTION_TYPE;
        }
        if (params.ABILITY_NAME !== undefined) {
            this.ABILITY_NAME = params.ABILITY_NAME;
        }
        if (params.FULL_WIDTH_PERCENT !== undefined) {
            this.FULL_WIDTH_PERCENT = params.FULL_WIDTH_PERCENT;
        }
        if (params.FULL_HEIGHT_PERCENT !== undefined) {
            this.FULL_HEIGHT_PERCENT = params.FULL_HEIGHT_PERCENT;
        }
        if (params.EMPTY_IMAGE_WIDTH !== undefined) {
            this.EMPTY_IMAGE_WIDTH = params.EMPTY_IMAGE_WIDTH;
        }
        if (params.AGENCY_COMPONENT_HEIGHT !== undefined) {
            this.AGENCY_COMPONENT_HEIGHT = params.AGENCY_COMPONENT_HEIGHT;
        }
        if (params.EMPTY_IMAGE_HEIGHT !== undefined) {
            this.EMPTY_IMAGE_HEIGHT = params.EMPTY_IMAGE_HEIGHT;
        }
        if (params.TEXT_MARGIN_TOP !== undefined) {
            this.TEXT_MARGIN_TOP = params.TEXT_MARGIN_TOP;
        }
        if (params.CROSS_BAR_SYMBOL !== undefined) {
            this.CROSS_BAR_SYMBOL = params.CROSS_BAR_SYMBOL;
        }
        if (params.SLASHES !== undefined) {
            this.SLASHES = params.SLASHES;
        }
        if (params.TARGET_VALUE_SPLICING !== undefined) {
            this.TARGET_VALUE_SPLICING = params.TARGET_VALUE_SPLICING;
        }
        if (params.LIST_SPACE !== undefined) {
            this.LIST_SPACE = params.LIST_SPACE;
        }
        if (params.LIST_TWO_LANES !== undefined) {
            this.LIST_TWO_LANES = params.LIST_TWO_LANES;
        }
        if (params.TEXT_OPACITY !== undefined) {
            this.TEXT_OPACITY = params.TEXT_OPACITY;
        }
        if (params.TARGET_TEXT_OPACITY !== undefined) {
            this.TARGET_TEXT_OPACITY = params.TARGET_TEXT_OPACITY;
        }
        if (params.TARGET_TEXT_WEIGHT !== undefined) {
            this.TARGET_TEXT_WEIGHT = params.TARGET_TEXT_WEIGHT;
        }
        if (params.TEXT_SLIGHTLY_BOLD !== undefined) {
            this.TEXT_SLIGHTLY_BOLD = params.TEXT_SLIGHTLY_BOLD;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        this.__taskList.aboutToBeDeleted();
        this.__showWidget.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get taskList() {
        return this.__taskList.get();
    }
    set taskList(newValue) {
        this.__taskList.set(newValue);
    }
    get showWidget() {
        return this.__showWidget.get();
    }
    set showWidget(newValue) {
        this.__showWidget.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.debugLine("agency/pages/AgencyCard.ets(117:5)");
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            If.create();
            if (this.showWidget) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        List.create({ space: this.LIST_SPACE });
                        List.debugLine("agency/pages/AgencyCard.ets(119:9)");
                        List.padding({
                            left: { "id": 16777277, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
                            top: { "id": 16777279, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
                            right: { "id": 16777278, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
                            bottom: { "id": 16777276, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" }
                        });
                        List.lanes(this.LIST_TWO_LANES);
                        List.backgroundColor({ "id": 16777389, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        List.width(this.FULL_WIDTH_PERCENT);
                        List.height(this.FULL_HEIGHT_PERCENT);
                        if (!isInitialRender) {
                            List.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        ForEach.create();
                        const forEachItemGenFunction = _item => {
                            const taskItem = _item;
                            {
                                const isLazyCreate = true;
                                const itemCreation = (elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    ListItem.create(deepRenderFunction, isLazyCreate);
                                    ListItem.margin({ right: { "id": 16777274, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } });
                                    ListItem.borderRadius({ "id": 16777275, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                                    ListItem.backgroundColor(Color.White);
                                    ListItem.debugLine("agency/pages/AgencyCard.ets(121:13)");
                                    if (!isInitialRender) {
                                        ListItem.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                };
                                const observedShallowRender = () => {
                                    this.observeComponentCreation(itemCreation);
                                    ListItem.pop();
                                };
                                const observedDeepRender = () => {
                                    this.observeComponentCreation(itemCreation);
                                    this.AgencyComponent.bind(this)(taskItem);
                                    ListItem.pop();
                                };
                                const deepRenderFunction = (elmtId, isInitialRender) => {
                                    itemCreation(elmtId, isInitialRender);
                                    this.updateFuncByElmtId.set(elmtId, itemCreation);
                                    this.AgencyComponent.bind(this)(taskItem);
                                    ListItem.pop();
                                };
                                if (isLazyCreate) {
                                    observedShallowRender();
                                }
                                else {
                                    observedDeepRender();
                                }
                            }
                        };
                        this.forEachUpdateFunction(elmtId, this.taskList, forEachItemGenFunction, item => JSON.stringify(item), false, false);
                        if (!isInitialRender) {
                            ForEach.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    ForEach.pop();
                    List.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.AgencyNoData.bind(this)();
                });
            }
            if (!isInitialRender) {
                If.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        If.pop();
        Column.pop();
    }
    AgencyNoData(parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.debugLine("agency/pages/AgencyCard.ets(146:5)");
            Column.justifyContent(FlexAlign.Center);
            Column.width(this.FULL_WIDTH_PERCENT);
            Column.height(this.FULL_HEIGHT_PERCENT);
            Column.backgroundColor({ "id": 16777391, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Column.onClick(() => {
                this.jumpToAbility();
            });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 16777247, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.debugLine("agency/pages/AgencyCard.ets(147:7)");
            Image.width(this.EMPTY_IMAGE_WIDTH);
            Image.height(this.EMPTY_IMAGE_HEIGHT);
            Image.objectFit(ImageFit.Contain);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create({ "id": 16777226, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.debugLine("agency/pages/AgencyCard.ets(151:7)");
            Text.fontSize({ "id": 16777318, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontColor(Color.White);
            Text.fontWeight(FontWeight.Normal);
            Text.opacity(this.TEXT_OPACITY);
            Text.margin({ top: this.TEXT_MARGIN_TOP });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Column.pop();
    }
    AgencyComponent(taskItem, parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.debugLine("agency/pages/AgencyCard.ets(168:5)");
            Row.padding({
                left: { "id": 16777280, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
                right: { "id": 16777280, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" }
            });
            Row.width(this.FULL_WIDTH_PERCENT);
            Row.height(this.AGENCY_COMPONENT_HEIGHT);
            Row.onClick(() => {
                this.jumpToAbility();
            });
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create(this.iconList[taskItem.taskType]);
            Image.debugLine("agency/pages/AgencyCard.ets(169:7)");
            Image.width({ "id": 16777273, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.height({ "id": 16777273, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.objectFit(ImageFit.Contain);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            If.create();
            if (taskItem.dateType) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Text.create(taskItem.isDone ? taskItem.targetValue : this.TARGET_VALUE_SPLICING + taskItem.targetValue);
                        Text.debugLine("agency/pages/AgencyCard.ets(174:9)");
                        Text.fontSize({ "id": 16777326, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        Text.fontColor({ "id": 16777400, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        Text.opacity(this.TARGET_TEXT_OPACITY);
                        Text.fontWeight(FontWeight.Normal);
                        Text.layoutWeight(this.TARGET_TEXT_WEIGHT);
                        Text.textAlign(TextAlign.End);
                        if (!isInitialRender) {
                            Text.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    Text.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Row.create();
                        Row.debugLine("agency/pages/AgencyCard.ets(182:9)");
                        Row.layoutWeight(this.TARGET_TEXT_WEIGHT);
                        Row.justifyContent(FlexAlign.End);
                        if (!isInitialRender) {
                            Row.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Text.create(taskItem.finValueIsNull ? this.CROSS_BAR_SYMBOL : taskItem.finValue);
                        Text.debugLine("agency/pages/AgencyCard.ets(183:11)");
                        Text.fontSize(taskItem.finValueIsNull ? { "id": 16777326, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } : { "id": 16777281, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        Text.fontWeight(taskItem.finValueIsNull ? FontWeight.Normal : this.TEXT_SLIGHTLY_BOLD);
                        Text.fontColor(taskItem.finValueIsNull ? { "id": 16777385, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } : { "id": 16777400, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        if (!isInitialRender) {
                            Text.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    Text.pop();
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Text.create(this.SLASHES + taskItem.targetValue);
                        Text.debugLine("agency/pages/AgencyCard.ets(191:11)");
                        Text.fontSize({ "id": 16777326, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        Text.fontWeight(FontWeight.Normal);
                        Text.fontColor({ "id": 16777385, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        if (!isInitialRender) {
                            Text.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    Text.pop();
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Text.create(taskItem.unit);
                        Text.debugLine("agency/pages/AgencyCard.ets(195:11)");
                        Text.fontSize({ "id": 16777326, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        Text.fontWeight(FontWeight.Normal);
                        Text.fontColor({ "id": 16777385, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                        if (!isInitialRender) {
                            Text.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    Text.pop();
                    Row.pop();
                });
            }
            if (!isInitialRender) {
                If.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        If.pop();
        Row.pop();
    }
    jumpToAbility() {
        postCardAction(this, {
            'action': this.ACTION_TYPE,
            'abilityName': this.ABILITY_NAME
        });
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadEtsCard(new AgencyCard(undefined, {}, agencyStorage), "com.example.healthy_life/entry/ets/agency/pages/AgencyCard");
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=AgencyCard.js.map