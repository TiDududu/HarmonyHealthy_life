import { FONT_WEIGHT_400, OPACITY_6, OPACITY_4,FULL_WIDTH } from '../../common/constants/CommonConstants';

@Extend(Text) function descStyle () {
  .fontSize($r('app.float.default_14'))
  .fontWeight(FONT_WEIGHT_400)
  .fontFamily($r('app.string.HarmonyHeiTi'))
  .fontColor($r(`app.element.color.titleColor`))
  .width(FULL_WIDTH)
  .lineHeight($r('app.float.default_20'))
  .margin({ top: $r('app.float.default_8') })
}
@CustomDialog
export default struct PersonalSexDialogController {
  @Consume sex: string;
  controller: CustomDialogController;
  cancel: () => void;
  name:string;
  select:number;


  confirm(){
    this.sex = this.name;
  }
  build() {
    Column() {
      Text($r('app.string.sex'))
        .descStyle()
      TextPicker({ range: ['男', '女', '保密'], selected: this.select })
        .onChange((value: string, index: number) => {
          this.name = value
        })
      Row() {
        Button($r('app.string.cancel'))
          .backgroundColor(Color.White)
          .fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.controller.close();
            // this.cancel();
          })
        Divider()
          .vertical(true)
          .height($r('app.float.default_22'))
          .opacity(OPACITY_4)
        Button($r('app.string.sure'))
          .backgroundColor(Color.White)
          .fontColor($r('app.color.blueColor'))
          .onClick(() => {
            this.controller.close();
            this.confirm();
          })
      }
      .width(FULL_WIDTH)
      .margin({ top: $r('app.float.default_22') })
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .padding($r('app.float.default_16'))
  }
}