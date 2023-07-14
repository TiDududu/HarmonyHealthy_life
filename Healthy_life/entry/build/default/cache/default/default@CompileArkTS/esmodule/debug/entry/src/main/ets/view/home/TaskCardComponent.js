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
import { TaskMapById } from '@bundle:com.example.healthy_life/entry/ets/model/TaskInitList';
import HealthText from '@bundle:com.example.healthy_life/entry/ets/view/HealthTextComponent';
import * as commonConst from '@bundle:com.example.healthy_life/entry/ets/common/constants/CommonConstants';
function __Text__labelTextStyle() {
    Text.fontSize({ "id": 16777305, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
    Text.fontWeight(commonConst.FONT_WEIGHT_500);
    Text.opacity(commonConst.OPACITY_6);
    Text.fontFamily({ "id": 16777222, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
}
export class TaskCard extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__taskInfoStr = new SynchedPropertySimpleOneWayPU(params.taskInfoStr, this, "taskInfoStr");
        this.clickAction = undefined;
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.clickAction !== undefined) {
            this.clickAction = params.clickAction;
        }
    }
    updateStateVars(params) {
        this.__taskInfoStr.reset(params.taskInfoStr);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__taskInfoStr.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__taskInfoStr.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get taskInfoStr() {
        return this.__taskInfoStr.get();
    }
    set taskInfoStr(newValue) {
        this.__taskInfoStr.set(newValue);
    }
    targetValueBuilder(parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            If.create();
            if (JSON.parse(this.taskInfoStr).isDone) {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            if (isInitialRender) {
                                ViewPU.create(new HealthText(this, { title: '', titleResource: { "id": 16777259, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } }, undefined, elmtId));
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                    title: ''
                                });
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                    }
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Row.create();
                        if (!isInitialRender) {
                            Row.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    {
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            if (isInitialRender) {
                                ViewPU.create(new HealthText(this, {
                                    title: JSON.parse(this.taskInfoStr).finValue || `--`,
                                    fontSize: { "id": 16777310, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" }
                                }, undefined, elmtId));
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                    title: JSON.parse(this.taskInfoStr).finValue || `--`
                                });
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                    }
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Text.create(` / ${JSON.parse(this.taskInfoStr).targetValue} ${TaskMapById[JSON.parse(this.taskInfoStr).taskID].unit}`);
                        __Text__labelTextStyle();
                        Text.fontWeight(commonConst.FONT_WEIGHT_400);
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
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width(commonConst.THOUSANDTH_1000);
            Row.height(commonConst.THOUSANDTH_1000);
            Row.justifyContent(FlexAlign.SpaceBetween);
            Row.borderRadius({ "id": 16777310, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Row.padding({ left: commonConst.THOUSANDTH_50, right: commonConst.THOUSANDTH_33 });
            Row.backgroundColor({ "id": 16777288, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Row.onClick(() => this.clickAction(true));
            Gesture.create(GesturePriority.Low);
            LongPressGesture.create();
            LongPressGesture.onAction(() => this.clickAction(false));
            LongPressGesture.pop();
            Gesture.pop();
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create({ space: commonConst.DEFAULT_6 });
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create(TaskMapById[JSON.parse(this.taskInfoStr).taskID].icon);
            Image.width({ "id": 16777315, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.height({ "id": 16777315, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.objectFit(ImageFit.Contain);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new HealthText(this, {
                        title: '',
                        titleResource: TaskMapById[JSON.parse(this.taskInfoStr).taskID].taskName,
                        fontFamily: { "id": 16777222, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" }
                    }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        title: ''
                    });
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        Row.pop();
        this.targetValueBuilder.bind(this)();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=TaskCardComponent.js.map