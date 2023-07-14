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
import * as commonConst from '@bundle:com.example.healthy_life/entry/ets/common/constants/CommonConstants';
import { AchievementMap } from '@bundle:com.example.healthy_life/entry/ets/model/TaskInitList';
const ANGLE_LARGE = 360;
export class AchievementDialog extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.controller = undefined;
        this.__achievementLevel = this.initializeConsume("achievementLevel", "achievementLevel");
        this.__opacityValue = new ObservedPropertySimplePU(0, this, "opacityValue");
        this.__angle = new ObservedPropertySimplePU(0, this, "angle");
        this.__scaleValue = new ObservedPropertySimplePU(0, this, "scaleValue");
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
        if (params.opacityValue !== undefined) {
            this.opacityValue = params.opacityValue;
        }
        if (params.angle !== undefined) {
            this.angle = params.angle;
        }
        if (params.scaleValue !== undefined) {
            this.scaleValue = params.scaleValue;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__opacityValue.purgeDependencyOnElmtId(rmElmtId);
        this.__angle.purgeDependencyOnElmtId(rmElmtId);
        this.__scaleValue.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__achievementLevel.aboutToBeDeleted();
        this.__opacityValue.aboutToBeDeleted();
        this.__angle.aboutToBeDeleted();
        this.__scaleValue.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    setController(ctr) {
        this.controller = ctr;
    }
    get achievementLevel() {
        return this.__achievementLevel.get();
    }
    set achievementLevel(newValue) {
        this.__achievementLevel.set(newValue);
    }
    get opacityValue() {
        return this.__opacityValue.get();
    }
    set opacityValue(newValue) {
        this.__opacityValue.set(newValue);
    }
    get angle() {
        return this.__angle.get();
    }
    set angle(newValue) {
        this.__angle.set(newValue);
    }
    get scaleValue() {
        return this.__scaleValue.get();
    }
    set scaleValue(newValue) {
        this.__scaleValue.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.height(commonConst.THOUSANDTH_800);
            Column.width(commonConst.THOUSANDTH_1000);
            Column.justifyContent(FlexAlign.Center);
            Gesture.create(GesturePriority.Low);
            TapGesture.create();
            TapGesture.onAction(() => {
                this.controller.close();
            });
            TapGesture.pop();
            Gesture.pop();
            Column.scale({ x: this.scaleValue, y: this.scaleValue });
            Column.rotate({ x: 0, y: 1, z: 0, angle: this.angle });
            Column.opacity(this.opacityValue);
            Column.onAppear(() => {
                Context.animateTo({
                    duration: commonConst.DURATION_800,
                    curve: Curve.EaseOut,
                    delay: commonConst.DURATION_100,
                    iterations: 1
                }, () => {
                    this.opacityValue = 1;
                    this.scaleValue = 1;
                    this.angle = ANGLE_LARGE;
                });
            });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create(AchievementMap[`${this.achievementLevel}_on`]);
            Image.width(commonConst.THOUSANDTH_560);
            Image.height(commonConst.THOUSANDTH_400);
            Image.objectFit(ImageFit.Contain);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create({ "id": 16777256, "type": 10003, params: [this.achievementLevel], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontSize({ "id": 16777310, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontWeight(commonConst.FONT_WEIGHT_500);
            Text.fontColor({ "id": 16777288, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontFamily({ "id": 16777222, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.margin({ top: { "id": 16777301, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=AchievementDialog.js.map