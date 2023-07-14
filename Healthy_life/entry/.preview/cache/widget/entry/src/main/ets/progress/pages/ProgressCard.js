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
let progressStorage = new LocalStorage();
class ProgressCard extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__numerator = this.createLocalStorageProp("numerator", 0, "numerator");
        this.__denominator = this.createLocalStorageProp("denominator", 0, "denominator");
        this.__percent = this.createLocalStorageProp("percent", '0', "percent");
        this.ACTION_TYPE = 'router';
        this.ABILITY_NAME = 'EntryAbility';
        this.FULL_WIDTH_PERCENT = '100%';
        this.FULL_HEIGHT_PERCENT = '100%';
        this.PROGRESS_LAYOUT_HEIGHT = '80%';
        this.RESULTS_LAYOUT_HEIGHT = '20%';
        this.PERCENTAGE = '%';
        this.SLASHES = '/';
        this.PROGRESS_TOTAL = 100;
        this.TEXT_SLIGHTLY_BOLD = 500;
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
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
        if (params.PROGRESS_LAYOUT_HEIGHT !== undefined) {
            this.PROGRESS_LAYOUT_HEIGHT = params.PROGRESS_LAYOUT_HEIGHT;
        }
        if (params.RESULTS_LAYOUT_HEIGHT !== undefined) {
            this.RESULTS_LAYOUT_HEIGHT = params.RESULTS_LAYOUT_HEIGHT;
        }
        if (params.PERCENTAGE !== undefined) {
            this.PERCENTAGE = params.PERCENTAGE;
        }
        if (params.SLASHES !== undefined) {
            this.SLASHES = params.SLASHES;
        }
        if (params.PROGRESS_TOTAL !== undefined) {
            this.PROGRESS_TOTAL = params.PROGRESS_TOTAL;
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
        this.__numerator.aboutToBeDeleted();
        this.__denominator.aboutToBeDeleted();
        this.__percent.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get numerator() {
        return this.__numerator.get();
    }
    set numerator(newValue) {
        this.__numerator.set(newValue);
    }
    get denominator() {
        return this.__denominator.get();
    }
    set denominator(newValue) {
        this.__denominator.set(newValue);
    }
    get percent() {
        return this.__percent.get();
    }
    set percent(newValue) {
        this.__percent.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.debugLine("progress/pages/ProgressCard.ets(76:5)");
            Column.backgroundColor({ "id": 16777396, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Column.width(this.FULL_WIDTH_PERCENT);
            Column.height(this.FULL_HEIGHT_PERCENT);
            Column.onClick(() => {
                postCardAction(this, {
                    'action': this.ACTION_TYPE,
                    'abilityName': this.ABILITY_NAME
                });
            });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Stack.create();
            Stack.debugLine("progress/pages/ProgressCard.ets(77:7)");
            Stack.height(this.PROGRESS_LAYOUT_HEIGHT);
            if (!isInitialRender) {
                Stack.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Progress.create({ value: 0, total: this.PROGRESS_TOTAL, type: ProgressType.Ring });
            Progress.debugLine("progress/pages/ProgressCard.ets(78:9)");
            Progress.value(Number.parseInt(this.percent));
            Progress.width({ "id": 16777324, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Progress.height({ "id": 16777324, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Progress.backgroundColor({ "id": 16777395, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Progress.style({ strokeWidth: { "id": 16777325, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } });
            if (!isInitialRender) {
                Progress.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.debugLine("progress/pages/ProgressCard.ets(84:9)");
            Row.justifyContent(FlexAlign.Center);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.percent);
            Text.debugLine("progress/pages/ProgressCard.ets(85:11)");
            Text.fontSize({ "id": 16777323, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontColor(Color.Black);
            Text.fontWeight(FontWeight.Normal);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.PERCENTAGE);
            Text.debugLine("progress/pages/ProgressCard.ets(89:11)");
            Text.fontSize({ "id": 16777322, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontColor(Color.Black);
            Text.fontWeight(this.TEXT_SLIGHTLY_BOLD);
            Text.margin({ top: { "id": 16777321, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        Stack.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.debugLine("progress/pages/ProgressCard.ets(99:7)");
            Row.height(this.RESULTS_LAYOUT_HEIGHT);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.numerator.toString());
            Text.debugLine("progress/pages/ProgressCard.ets(100:9)");
            Text.fontColor({ "id": 16777392, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontSize({ "id": 16777320, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.lineHeight({ "id": 16777319, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontWeight(FontWeight.Normal);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.SLASHES + this.denominator);
            Text.debugLine("progress/pages/ProgressCard.ets(105:9)");
            Text.fontColor({ "id": 16777383, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontSize({ "id": 16777317, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.lineHeight({ "id": 16777316, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontWeight(FontWeight.Normal);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadEtsCard(new ProgressCard(undefined, {}, progressStorage), "com.example.healthy_life/entry/ets/progress/pages/ProgressCard");
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=ProgressCard.js.map