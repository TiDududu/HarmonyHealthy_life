export const columnGlobalInfoList = [
    {
        name: 'id',
        type: 'integer',
        primary: true,
        nullable: true
    },
    {
        name: 'firstDate',
        type: 'text'
    },
    {
        name: 'lastDate',
        type: 'text'
    },
    {
        name: 'checkInDays',
        type: 'integer',
        nullable: true
    },
    {
        name: 'achievements',
        type: 'text'
    }
];
export const columnDayInfoList = [
    {
        name: 'date',
        type: 'text',
        primary: true
    },
    {
        name: 'targetTaskNum',
        type: 'integer',
        nullable: true
    },
    {
        name: 'finTaskNum',
        type: 'integer',
        nullable: true
    }
];
export const columnTaskInfoInfoList = [
    {
        name: 'id',
        type: 'integer',
        primary: true,
        autoincrement: true
    },
    {
        name: 'date',
        type: 'TEXT'
    },
    {
        name: 'taskID',
        type: 'integer'
    },
    {
        name: 'targetValue',
        type: 'text'
    },
    {
        name: 'isAlarm',
        type: 'boolean'
    },
    {
        name: 'startTime',
        type: 'text'
    },
    {
        name: 'endTime',
        type: 'text'
    },
    {
        name: 'frequency',
        type: 'text'
    },
    {
        name: 'isDone',
        type: 'boolean',
        nullable: true
    },
    {
        name: 'finValue',
        type: 'text'
    },
    {
        name: 'isOpen',
        type: 'boolean',
        nullable: true
    }
];
export const columnFormInfoList = [
    {
        name: 'id',
        type: 'integer',
        primary: true,
        nullable: true
    },
    {
        name: 'formId',
        type: 'text'
    },
    {
        name: 'formName',
        type: 'text'
    },
    {
        name: 'formDimension',
        type: 'integer'
    }
];
//# sourceMappingURL=RdbColumnModel.js.map