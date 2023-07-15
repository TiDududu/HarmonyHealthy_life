import picker from '@ohos.file.picker';
import { FONT_WEIGHT_400, OPACITY_6, OPACITY_4,FULL_WIDTH } from '../../common/constants/CommonConstants';
import { NICK_NAME, SIGNATURE, FULL_HEIGHT } from '../../common/constants/CommonConstants';
import Logger from '../../common/utils/Logger';
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
export default struct PersonalImageDialogController {
  @Consume image: string;
  controller: CustomDialogController;
  cancel: () => void;
  name:string = 'app.media.ic_user';

  PhotoSelectOptions :picker.PhotoSelectOptions = new picker.PhotoSelectOptions();
  photoPicker :picker.PhotoViewPicker = new picker.PhotoViewPicker();
  confirm(){
    this.image = this.name;
  }
  build() {
    Column() {
      Button($r('app.string.image'))
        .backgroundColor(Color.White)
        .fontColor($r('app.color.blueColor'))
        .onClick(() => {
          this.PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
          this.PhotoSelectOptions.maxSelectNumber = 1;
          this.photoPicker.select(this.PhotoSelectOptions).then((PhotoSelectResult) => {
            this.name = PhotoSelectResult.photoUris.toString()
            Logger.info('PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult));
          }).catch((err) => {
            Logger.info('PhotoViewPicker.select failed with err: ' + err);
          });
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