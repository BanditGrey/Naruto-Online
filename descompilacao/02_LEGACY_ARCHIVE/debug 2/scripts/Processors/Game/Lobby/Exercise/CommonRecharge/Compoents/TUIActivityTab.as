package Processors.Game.Lobby.Exercise.CommonRecharge.Compoents
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.CommonRecharge.TCommonRecharge;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMONRECHARGE;
   import Resources.Strings.STRING_COMMONRECHARGE;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TUIActivityTab extends TUIComponent
   {
      
      protected var FMC_Scene:MovieClip;
      
      protected var FTF_Num:TextField;
      
      protected var FCommonRecharge:TCommonRecharge;
      
      protected var FIndex:int;
      
      public function TUIActivityTab(param1:TUIComponent)
      {
         super(param1);
         this.FCommonRecharge = SLogicsCore.CommonRecharge;
      }
      
      protected function Initialization() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMONRECHARGE.RESOURCE_ClassName_ActivityDescT) as MovieClip;
         addChild(this.FMC_Scene);
         this.FTF_Num = this.FMC_Scene.TF_Num;
      }
      
      protected function UpdateContent() : void
      {
         this.FMC_Scene.gotoAndStop(this.FCommonRecharge.TabID[this.FIndex]);
         this.FTF_Num.text = TUtilityString.Format(STRING_COMMONRECHARGE.FORMAT_TAB_TEXT,this.FIndex + 1);
      }
      
      public function Init() : void
      {
         this.Initialization();
      }
      
      public function SetItemInfo(param1:uint) : void
      {
         this.FIndex = param1;
         this.UpdateContent();
      }
   }
}

