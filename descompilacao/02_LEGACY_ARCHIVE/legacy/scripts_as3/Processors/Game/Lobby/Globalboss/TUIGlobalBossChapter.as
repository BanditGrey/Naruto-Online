package Processors.Game.Lobby.Globalboss
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Globalboss.TGlobalbossChapter;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIGlobalBossChapter extends TUIComponent
   {
      
      protected var FGlobalbossChapter:TGlobalbossChapter;
      
      protected var FUICompoent:MovieClip;
      
      public var OnOpenGlobalboss:Function;
      
      public var OnOpenAward:Function;
      
      public function TUIGlobalBossChapter(param1:TUIComponent)
      {
         super(param1);
         this.ResourcesUIDispatch();
      }
      
      protected function ResourcesUIDispatch() : void
      {
         this.FUICompoent = TUtilityReflection.CreateDisplayObjectInstance("globalbossChapter") as MovieClip;
         addChild(this.FUICompoent);
         TGameUtil.setButtonMode(this.FUICompoent.Btn_chapter,true);
         this.FUICompoent.Btn_chapter.addEventListener(MouseEvent.CLICK,this.OnClickBtnChapter);
         TGameUtil.setButtonMode(this.FUICompoent.Btn_Award,true);
         this.FUICompoent.Btn_Award.addEventListener(MouseEvent.CLICK,this.OnClickBtnAward);
      }
      
      public function setData(param1:TGlobalbossChapter) : void
      {
         this.FGlobalbossChapter = param1;
         this.FUICompoent.MC_suo.visible = this.FUICompoent.maskbg.visible = this.FUICompoent.TF_condition.visible = !param1.unlock;
         this.FUICompoent.TF_chapter.text = param1.DafubenAward.Chaptername;
         this.FUICompoent.TF_condition.text = param1.DafubenAward.Dec;
         this.FUICompoent.TF_star.text = param1.starNum + "/30";
      }
      
      protected function OnClickBtnChapter(param1:MouseEvent) : void
      {
         if(this.OnOpenGlobalboss != null)
         {
            this.OnOpenGlobalboss({
               "identity":this.FGlobalbossChapter.Identity,
               "level":this.FGlobalbossChapter.DafubenAward.Level
            });
         }
      }
      
      protected function OnClickBtnAward(param1:MouseEvent) : void
      {
         if(this.OnOpenAward != null)
         {
            this.OnOpenAward(this.FGlobalbossChapter);
         }
      }
   }
}

