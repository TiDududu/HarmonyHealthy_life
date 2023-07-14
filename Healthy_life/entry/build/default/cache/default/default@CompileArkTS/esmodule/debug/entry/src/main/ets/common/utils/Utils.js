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
const CHINESE_OF_WEEK = ['一', '二', '三', '四', '五', '六', '日'];
const YEAR = '年';
const MONTH = '月';
const DAY = '日';
const WEEK = '星期';
const DAYS_OF_WEEK = 7;
const SUNDAY_FIRST_SHIFT = 6;
export const weekTitleFunc = () => {
    const weekTitleArr = [];
    for (let index = 0; index < CHINESE_OF_WEEK.length; index++) {
        weekTitleArr.push(CHINESE_OF_WEEK[(index + SUNDAY_FIRST_SHIFT) % DAYS_OF_WEEK]); // Sunday is the first day
    }
    return weekTitleArr;
};
export const WEEK_TITLES = weekTitleFunc();
// one digit or two number convert into two digit time format
export function padTo2Digits(num) {
    return num.toString().padStart(2, '0');
}
export function dateFormat(date) {
    return date.getFullYear() + YEAR + padTo2Digits(date.getMonth() + 1) + MONTH + padTo2Digits(date.getDate()) + DAY;
}
// date convert into format of 'Fri Aug 26 2022'
export function dateToStr(date) {
    return date.toDateString();
}
export function weekDateFormat(timestamp) {
    let tempDate = new Date(timestamp);
    return dateFormat(tempDate) + WEEK + WEEK_TITLES[tempDate.getDay()];
}
export function sameDate(firstDate, timestamp) {
    let secondDate = new Date(timestamp);
    if (firstDate.getFullYear() != secondDate.getFullYear()) {
        return false;
    }
    if (firstDate.getMonth() != secondDate.getMonth()) {
        return false;
    }
    if (firstDate.getDate() != secondDate.getDate()) {
        return false;
    }
    return true;
}
export function ratio2percent(ratio) {
    return `${ratio * 100}%`;
}
export const frequencyRange = () => {
    const frequencyRangeArr = [];
    CHINESE_OF_WEEK.forEach((item, index) => {
        frequencyRangeArr.push({
            id: (index + 1),
            label: `${WEEK}${item}`,
            isChecked: false
        });
    });
    return frequencyRangeArr;
};
export const oneWeekDictFunc = () => {
    const oneWeekDict = {};
    for (let index = 0; index < CHINESE_OF_WEEK.length; index++) {
        oneWeekDict[index + 1] = `${WEEK}${CHINESE_OF_WEEK[index]}`;
    }
    return oneWeekDict;
};
//# sourceMappingURL=Utils.js.map