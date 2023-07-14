/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
import router from '@ohos:router';
import Logger from '@bundle:com.example.healthy_life/entry/ets/common/utils/Logger';
import * as commonConst from '@bundle:com.example.healthy_life/entry/ets/common/constants/CommonConstants';
import { NavList, TabId } from '@bundle:com.example.healthy_life/entry/ets/model/NavItemModel';
import HomeIndex from '@bundle:com.example.healthy_life/entry/ets/view/HomeComponent';
import { AchievementIndex } from '@bundle:com.example.healthy_life/entry/ets/view/AchievementComponent';
import { MineIndex } from '@bundle:com.example.healthy_life/entry/ets/pages/MinePage';
import { HomeStore } from '@bundle:com.example.healthy_life/entry/ets/viewmodel/HomeViewModel';
import GlobalInfoApi from '@bundle:com.example.healthy_life/entry/ets/common/database/tables/GlobalInfoApi';
class Index extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__currentPage = new ObservedPropertySimplePU(0, this, "currentPage");
        this.__editedTaskInfo = new ObservedPropertyObjectPU(JSON.parse(router.getParams() ? router.getParams()['editTask'] : '{}'), this, "editedTaskInfo");
        this.__editedTaskID = new ObservedPropertySimplePU('0', this, "editedTaskID");
        this.__homeStore = new ObservedPropertyObjectPU(new HomeStore(new Date()), this, "homeStore");
        this.tabController = new TabsController();
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.currentPage !== undefined) {
            this.currentPage = params.currentPage;
        }
        if (params.editedTaskInfo !== undefined) {
            this.editedTaskInfo = params.editedTaskInfo;
        }
        if (params.editedTaskID !== undefined) {
            this.editedTaskID = params.editedTaskID;
        }
        if (params.homeStore !== undefined) {
            this.homeStore = params.homeStore;
        }
        if (params.tabController !== undefined) {
            this.tabController = params.tabController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentPage.purgeDependencyOnElmtId(rmElmtId);
        this.__editedTaskInfo.purgeDependencyOnElmtId(rmElmtId);
        this.__editedTaskID.purgeDependencyOnElmtId(rmElmtId);
        this.__homeStore.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentPage.aboutToBeDeleted();
        this.__editedTaskInfo.aboutToBeDeleted();
        this.__editedTaskID.aboutToBeDeleted();
        this.__homeStore.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get currentPage() {
        return this.__currentPage.get();
    }
    set currentPage(newValue) {
        this.__currentPage.set(newValue);
    }
    get editedTaskInfo() {
        return this.__editedTaskInfo.get();
    }
    set editedTaskInfo(newValue) {
        this.__editedTaskInfo.set(newValue);
    }
    get editedTaskID() {
        return this.__editedTaskID.get();
    }
    set editedTaskID(newValue) {
        this.__editedTaskID.set(newValue);
    }
    get homeStore() {
        return this.__homeStore.get();
    }
    set homeStore(newValue) {
        this.__homeStore.set(newValue);
    }
    onPageShow() {
        Logger.info('onPageShow', JSON.stringify(router.getParams()));
        this.editedTaskInfo = JSON.parse(router.getParams() ? router.getParams()['editTask'] : '{}');
        this.editedTaskID = JSON.stringify(this.editedTaskInfo);
        if (globalThis.isForeground) {
            globalThis.isForeground = false;
            if (this.homeStore.currentDate.getDate() !== (new Date()).getDate()) {
                globalThis.taskListChange = true;
                this.homeStore = new HomeStore(new Date());
            }
            this.checkCurrentTime();
        }
    }
    checkCurrentTime() {
        GlobalInfoApi.query((result) => {
            let predate = new Date(result.lastDate);
            let date = new Date();
            if (result.length !== 0 && date.getTime() < predate.getTime()) {
                AlertDialog.show({
                    title: { "id": 16777229, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
                    message: { "id": 16777231, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
                    autoCancel: false,
                    alignment: DialogAlignment.Bottom,
                    offset: { dx: 0, dy: -20 },
                    gridCount: 3,
                    confirm: {
                        value: { "id": 16777230, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
                        action: () => {
                            getContext(this).terminateSelf();
                            console.info('Button-clicking callback');
                        }
                    },
                    cancel: () => {
                        console.info('Closed callbacks');
                    }
                });
            }
            else {
                this.homeStore.initData();
            }
        });
    }
    TabBuilder(index, parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.justifyContent(FlexAlign.Center);
            Column.width(commonConst.THOUSANDTH_1000);
            Column.height(commonConst.THOUSANDTH_1000);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create(index === this.currentPage ? NavList[index].icon_selected : NavList[index].icon);
            Image.width({ "id": 16777310, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.height({ "id": 16777310, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.objectFit(ImageFit.Contain);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(NavList[index].text);
            Text.fontSize({ "id": 16777299, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontWeight(commonConst.FONT_WEIGHT_500);
            Text.fontColor(this.currentPage === index ? { "id": 16777266, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } : { "id": 16777285, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.margin({ top: { "id": 16777316, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Tabs.create({ barPosition: BarPosition.End, controller: this.tabController });
            Tabs.scrollable(false);
            Tabs.width(commonConst.THOUSANDTH_1000);
            Tabs.height(commonConst.THOUSANDTH_1000);
            Tabs.barWidth(commonConst.THOUSANDTH_940);
            Tabs.barMode(BarMode.Fixed);
            Tabs.vertical(false);
            Tabs.onChange((index) => {
                this.currentPage = index;
            });
            if (!isInitialRender) {
                Tabs.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TabContent.create(() => {
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    __Common__.create();
                    __Common__.borderWidth({ bottom: 1 });
                    __Common__.borderColor({ "id": 16777279, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                    if (!isInitialRender) {
                        __Common__.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        if (isInitialRender) {
                            ViewPU.create(new HomeIndex(this, { homeStore: this.__homeStore, editedTaskInfo: this.__editedTaskInfo, editedTaskID: this.__editedTaskID }, undefined, elmtId));
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                }
                __Common__.pop();
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, TabId.HOME);
                } });
            TabContent.align(Alignment.Start);
            if (!isInitialRender) {
                TabContent.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        TabContent.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TabContent.create(() => {
                {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        if (isInitialRender) {
                            ViewPU.create(new AchievementIndex(this, {}, undefined, elmtId));
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, TabId.ACHIEVEMENT);
                } });
            if (!isInitialRender) {
                TabContent.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        TabContent.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TabContent.create(() => {
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    __Common__.create();
                    __Common__.borderWidth({ bottom: 1 });
                    __Common__.borderColor({ "id": 16777279, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                    if (!isInitialRender) {
                        __Common__.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        if (isInitialRender) {
                            ViewPU.create(new MineIndex(this, {}, undefined, elmtId));
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                }
                __Common__.pop();
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, TabId.MINE);
                } });
            if (!isInitialRender) {
                TabContent.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        TabContent.pop();
        Tabs.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new Index(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=MainPage.js.map