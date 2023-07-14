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
import display from '@ohos:display';
import WeekCalendarMethods from '@bundle:com.example.healthy_life/entry/ets/viewmodel/CalendarViewModel';
import HealthText from '@bundle:com.example.healthy_life/entry/ets/view/HealthTextComponent';
import { sameDate } from '@bundle:com.example.healthy_life/entry/ets/common/utils/Utils';
import * as commonConst from '@bundle:com.example.healthy_life/entry/ets/common/constants/CommonConstants';
import Logger from '@bundle:com.example.healthy_life/entry/ets/common/utils/Logger';
export const WEEK_DAY_WIDTH = 100 / commonConst.WEEK_DAY_NUM;
const DEFAULT_SCROLL_WIDTH = 336; // default calendar width
const DEFAULT_SCROLL_PERCENT = 0.934; // default calendar width percent
export class WeekCalendar extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__homeStore = new SynchedPropertyObjectTwoWayPU(params.homeStore, this, "homeStore");
        this.currentPage = 1;
        this.scroller = new Scroller();
        this.scrollWidth = DEFAULT_SCROLL_WIDTH;
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.currentPage !== undefined) {
            this.currentPage = params.currentPage;
        }
        if (params.scroller !== undefined) {
            this.scroller = params.scroller;
        }
        if (params.scrollWidth !== undefined) {
            this.scrollWidth = params.scrollWidth;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__homeStore.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__homeStore.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get homeStore() {
        return this.__homeStore.get();
    }
    set homeStore(newValue) {
        this.__homeStore.set(newValue);
    }
    aboutToAppear() {
        // get width
        try {
            let displayClass = display.getDefaultDisplaySync();
            this.scrollWidth = displayClass.width / displayClass.densityPixels * DEFAULT_SCROLL_PERCENT;
            Logger.info('HomeIndex', 'get the window scrollWidth: ' + this.scrollWidth);
        }
        catch (err) {
            Logger.error('HomeIndex->onScrollEnd', JSON.stringify(err));
        }
        this.homeStore.setSelectedShowDate(new Date().getTime());
    }
    getProgressImg(item) {
        var _a, _b;
        let finNum = ((_a = item.dayInfo) === null || _a === void 0 ? void 0 : _a.finTaskNum) || 0;
        if (finNum === 0) {
            return { "id": 16777375, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" };
        }
        if (finNum === (((_b = item.dayInfo) === null || _b === void 0 ? void 0 : _b.targetTaskNum) || 0)) {
            return { "id": 16777372, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" };
        }
        return { "id": 16777374, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" };
    }
    ArrowIcon(isRight, parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width({ "id": 16777307, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Row.height({ "id": 16777307, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Row.rotate({ z: 1, angle: isRight ? 0 : commonConst.DEFAULT_180 });
            Row.justifyContent(FlexAlign.Center);
            Row.onClick(() => isRight ? WeekCalendarMethods.goToNextWeek.call(this) : WeekCalendarMethods.gotoPreviousWeek.call(this));
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 16777378, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.width({ "id": 16777324, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.height({ "id": 16777301, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Row.pop();
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width(commonConst.THOUSANDTH_1000);
            Row.height(commonConst.THOUSANDTH_420);
            Row.padding(commonConst.THOUSANDTH_33);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.borderRadius({ "id": 16777310, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Column.backgroundColor({ "id": 16777288, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Column.width(commonConst.THOUSANDTH_1000);
            Column.height(commonConst.THOUSANDTH_1000);
            Column.padding({ top: commonConst.THOUSANDTH_50, bottom: commonConst.THOUSANDTH_120 });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.justifyContent(FlexAlign.Center);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.ArrowIcon.bind(this)(false);
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            __Common__.create();
            __Common__.margin({ "id": 16777301, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            if (!isInitialRender) {
                __Common__.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new HealthText(this, { title: this.homeStore.dateTitle, fontSize: { "id": 16777304, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        title: this.homeStore.dateTitle
                    });
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        __Common__.pop();
        this.ArrowIcon.bind(this)(true);
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Scroll.create(this.scroller);
            Scroll.scrollBar(BarState.Off);
            Scroll.scrollable(ScrollDirection.Horizontal);
            Scroll.width(commonConst.THOUSANDTH_1000);
            Scroll.onScrollStop(() => WeekCalendarMethods.onScrollEndAction.call(this));
            Scroll.onScrollEdge(() => WeekCalendarMethods.onScrollEdgeAction.call(this));
            if (!isInitialRender) {
                Scroll.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            ForEach.create();
            const forEachItemGenFunction = (_item, index) => {
                const item = _item;
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Column.create();
                    Column.width(`${WEEK_DAY_WIDTH}%`);
                    Column.justifyContent(FlexAlign.SpaceBetween);
                    Column.onClick(() => WeekCalendarMethods.calenderItemClickAction.call(this, item, index));
                    if (!isInitialRender) {
                        Column.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Text.create(item.weekTitle);
                    Text.fontSize({ "id": 16777301, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                    Text.fontWeight(commonConst.FONT_WEIGHT_500);
                    Text.fontColor(sameDate(item.date, this.homeStore.showDate) ? { "id": 16777266, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } : { "id": 16777287, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                    Text.fontFamily({ "id": 16777224, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                    Text.opacity(commonConst.OPACITY_6);
                    if (!isInitialRender) {
                        Text.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Text.pop();
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Divider.create();
                    Divider.margin({ top: commonConst.DEFAULT_2, bottom: { "id": 16777316, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } });
                    Divider.width({ "id": 16777301, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                    Divider.color(sameDate(item.date, this.homeStore.showDate) ? { "id": 16777266, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } : { "id": 16777288, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                    if (!isInitialRender) {
                        Divider.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Image.create(this.getProgressImg(item));
                    Image.height({ "id": 16777313, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
                    Image.objectFit(ImageFit.Contain);
                    Image.margin({ top: commonConst.THOUSANDTH_80 });
                    if (!isInitialRender) {
                        Image.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Column.pop();
            };
            this.forEachUpdateFunction(elmtId, this.homeStore.dateArr, forEachItemGenFunction, undefined, true, false);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        Row.pop();
        Scroll.pop();
        Column.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=WeekCalendarComponent.js.map