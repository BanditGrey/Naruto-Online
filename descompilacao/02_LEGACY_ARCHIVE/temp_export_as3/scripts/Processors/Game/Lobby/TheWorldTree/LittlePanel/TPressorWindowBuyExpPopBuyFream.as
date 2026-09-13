package Processors.Game.Lobby.TheWorldTree.LittlePanel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Strings.STRING_THEWORLDTREE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TPressorWindowBuyExpPopBuyFream extends TProcessorLobbyWindow
   {
      
      public static const Nine:int = 999;
      
      protected var FThisPanel:MovieClip;
      
      protected var FTF_Count:TextField;
      
      protected var FBTN_Reduce:SimpleButton;
      
      protected var FBTN_Add:SimpleButton;
      
      protected var FBtn_Max:MovieClip;
      
      protected var FCurCount:int = 1;
      
      protected var FTF_Label_dec:TextField;
      
      protected var FTF_Label_Time:TextField;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FTF_NormalPrice:TextField;
      
      protected var FMC_BuyBtn:MovieClip;
      
      protected var FMC_Close:SimpleButton;
      
      protected var FCurType:int;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var OnePrice:int;
      
      protected var FCurStr:String;
      
      protected var FBuyFunctionBack:Function;
      
      public function TPressorWindowBuyExpPopBuyFream(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FLogicDate = SLogicsCore.TheWorldTreeLogicData;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("TheWorldTree_GetExp") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_Icon = this.FThisPanel["MC_Icon"];
         this.FTF_Label_dec = this.FThisPanel["TF_Label_dec"];
         this.FTF_Label_Time = this.FThisPanel["TF_Label_Time"];
         this.FBtn_Max = this.FThisPanel["Btn_Max"];
         TGameUtil.setButtonMode(this.FBtn_Max,true);
         this.FTF_Count = this.FThisPanel["TF_Value"];
         this.FBTN_Reduce = this.FThisPanel["BTN_Reduce"];
         this.FBTN_Add = this.FThisPanel["BTN_Add"];
         this.FTF_Count.restrict = "0-9";
         this.FTF_Count.maxChars = 3;
         this.FTF_NormalPrice = this.FThisPanel["MC_NormalPrice"]["TF_NormalPrice"];
         this.FMC_BuyBtn = this.FThisPanel["MC_BuyBtn"];
         this.FMC_Close = this.FThisPanel["MC_Close"];
         TGameUtil.setButtonMode(this.FMC_BuyBtn,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Max.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FTF_Count.addEventListener(Event.CHANGE,this.OnTextInput);
         this.FBTN_Reduce.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FMC_BuyBtn.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FMC_Close.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ClichHandle(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBtn_Max:
               this.FCurCount = Nine;
               this.UpdateShowCount();
               break;
            case this.FBTN_Reduce:
               --this.FCurCount;
               this.UpdateShowCount();
               break;
            case this.FBTN_Add:
               ++this.FCurCount;
               this.UpdateShowCount();
               break;
            case this.FMC_BuyBtn:
               this.visible = false;
               if(this.FBuyFunctionBack != null)
               {
                  this.FBuyFunctionBack(this.FCurType,this.FCurCount);
               }
               break;
            case this.FMC_Close:
               this.visible = false;
         }
      }
      
      public function OneTimeEvent(param1:uint, param2:uint, param3:uint = 0) : void
      {
         var _loc4_:uint = 0;
         if(param3 == 0)
         {
            if(this.FCurType == 1)
            {
               _loc4_ = param1;
            }
            else
            {
               _loc4_ = param2;
            }
         }
         else if(this.FCurType == 1)
         {
            _loc4_ = this.FLogicDate.OnlineAdditionExpSurplusTimesCopy;
         }
         else
         {
            _loc4_ = this.FLogicDate.PropsAdditionExpSurplusTimes;
         }
         this.FTF_Label_Time.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str17).DescribeString,TGameUtil.fomatTime_NoDay(_loc4_));
      }
      
      public function OpenThiePanel() : void
      {
         this.FTF_Label_dec.text = TUtilityString.Format(this.FCurStr,SLogicsCore.TheWorldTreeLogicData.PropsDropOutPercent / 100);
      }
      
      protected function UpdateShowCount() : void
      {
         if(this.FCurCount > Nine)
         {
            this.FCurCount = Nine;
         }
         if(this.FCurCount < 1)
         {
            this.FCurCount = 1;
         }
         this.FTF_Count.text = String(this.FCurCount);
         switch(this.FCurType)
         {
            case 1:
               this.OnePrice = SLogicsCore.TheWorldTreeLogicData.BuyExpOneHourOrice;
               this.FCurStr = new ConsumeFrameCopy(STRING_THEWORLDTREE.str15).DescribeString;
               break;
            case 2:
               this.OnePrice = SLogicsCore.TheWorldTreeLogicData.PropsDropOutOneHourOrice;
               this.FCurStr = new ConsumeFrameCopy(STRING_THEWORLDTREE.str16).DescribeString;
         }
         this.FTF_NormalPrice.text = (this.FCurCount * this.OnePrice).toString();
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         this.FCurCount = int(this.FTF_Count.text) > 0 ? int(this.FTF_Count.text) : 1;
         this.UpdateShowCount();
      }
      
      public function set Type(param1:int) : void
      {
         if(param1 == 1)
         {
            this.FMC_Icon.gotoAndStop(2);
         }
         else
         {
            this.FMC_Icon.gotoAndStop(1);
         }
         this.FCurType = param1;
         this.FCurCount = 1;
         this.UpdateShowCount();
      }
      
      public function set BuyFunctionBack(param1:Function) : void
      {
         this.FBuyFunctionBack = param1;
      }
   }
}

