package Processors.Game.Lobby.BloodSoulPurgatory
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TChangeCountFream extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:Sprite;
      
      protected var FTF_Num:TextField;
      
      protected var FMC_BtnLeft:SimpleButton;
      
      protected var FMC_BtnRight:SimpleButton;
      
      protected var FMC_BtnMax:MovieClip;
      
      protected var FMC_BtnOk:MovieClip;
      
      protected var FMC_BtnCancel:MovieClip;
      
      protected var FCurCount:int = 1;
      
      protected var FLeftId:uint;
      
      protected var FLeftNum:uint;
      
      protected var FLeftCount:uint;
      
      protected var FRightId:uint;
      
      protected var FRightNum:uint;
      
      protected var FArital1:TArticle;
      
      protected var FArital2:TArticle;
      
      protected var FTF_Dec1:TextField;
      
      protected var FTF_Dec2:TextField;
      
      protected var FRate:int;
      
      protected var FCancelBtnBackFun:Function;
      
      protected var FSureBtnBackFun:Function;
      
      public function TChangeCountFream(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BLOODPURGATORY.BooldPurgatory_ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_ChangeFream_") as Sprite;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FTF_Num = this.FThisPanel["TF_Num"];
         this.FTF_Num.restrict = "0-9";
         this.FTF_Num.maxChars = 5;
         this.FMC_BtnLeft = this.FThisPanel["MC_BtnLeft"];
         this.FMC_BtnRight = this.FThisPanel["MC_BtnRight"];
         this.FMC_BtnMax = this.FThisPanel["MC_BtnMax"];
         this.FMC_BtnOk = this.FThisPanel["MC_BtnOk"];
         this.FMC_BtnCancel = this.FThisPanel["MC_BtnCancel"];
         this.FTF_Dec1 = this.FThisPanel["TF_Dec1"];
         this.FTF_Dec2 = this.FThisPanel["TF_Dec2"];
         TGameUtil.setButtonMode(this.FMC_BtnMax,true);
         TGameUtil.setButtonMode(this.FMC_BtnOk,true);
         TGameUtil.setButtonMode(this.FMC_BtnCancel,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FTF_Num.addEventListener(Event.CHANGE,this.OnTextInput);
         this.FMC_BtnMax.addEventListener(MouseEvent.CLICK,this.ClickEvent);
         this.FMC_BtnOk.addEventListener(MouseEvent.CLICK,this.ClickEvent);
         this.FMC_BtnCancel.addEventListener(MouseEvent.CLICK,this.ClickEvent);
         this.FMC_BtnLeft.addEventListener(MouseEvent.CLICK,this.ClickEvent);
         this.FMC_BtnRight.addEventListener(MouseEvent.CLICK,this.ClickEvent);
         super.ResourcesPerform_UILocations();
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         this.FCurCount = int(this.FTF_Num.text);
         this.SureCount();
      }
      
      protected function SureCount(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.FCurCount = this.FLeftCount / this.FLeftNum;
         }
         else
         {
            this.FCurCount = this.FCurCount > 0 ? this.FCurCount : 1;
            if(this.FCurCount * this.FRate > this.FLeftCount)
            {
               this.FCurCount = this.FLeftCount / this.FRate;
            }
         }
         this.FTF_Num.text = this.FCurCount.toString();
         this.FTF_Dec2.text = TUtilityString.Format(STRING_TONGLING.TONGLING_202,this.FCurCount * this.FRate,this.FArital1.Name,this.FCurCount,this.FArital2.Name);
      }
      
      public function SetValue(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         this.FLeftId = param1;
         this.FLeftNum = param2;
         this.FRightId = param3;
         this.FRightNum = param4;
         this.FLeftCount = SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FLeftId);
         this.FArital1 = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FLeftId) as TArticle;
         this.FArital2 = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FRightId) as TArticle;
         this.FTF_Dec1.text = TUtilityString.Format(STRING_TONGLING.TONGLING_201,this.FLeftNum,this.FArital1.Name,this.FRightNum,this.FArital2.Name);
         this.FRate = this.FLeftNum / this.FRightNum;
         this.FCurCount = 1;
         this.SureCount();
      }
      
      protected function ClickEvent(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_BtnMax:
               this.SureCount(true);
               break;
            case this.FMC_BtnOk:
               this.Visible = false;
               if(this.FSureBtnBackFun != null)
               {
                  this.FSureBtnBackFun(this.FLeftId,this.FRightId,this.FCurCount);
               }
               break;
            case this.FMC_BtnCancel:
               this.Visible = false;
               if(this.FCancelBtnBackFun != null)
               {
                  this.FCancelBtnBackFun();
               }
               break;
            case this.FMC_BtnLeft:
               --this.FCurCount;
               this.SureCount();
               break;
            case this.FMC_BtnRight:
               ++this.FCurCount;
               this.SureCount();
         }
      }
      
      public function set CancelBtnBackFun(param1:Function) : void
      {
         this.FCancelBtnBackFun = param1;
      }
      
      public function set SureBtnBackFun(param1:Function) : void
      {
         this.FSureBtnBackFun = param1;
      }
   }
}

