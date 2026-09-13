package Processors.Game.Lobby.Undertown.Panel
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TDungeonsPractise;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Strings.STRING_UNDERTOWN;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorUndertownFightingLog extends TProcessorLobbyWindow
   {
      
      public static const FOUR:int = 10;
      
      protected var FMainUI:Sprite;
      
      protected var FUIPage:TUIPage;
      
      protected var FCurPage:int;
      
      protected var TimeStr:Vector.<String>;
      
      protected var DecStr:Vector.<String>;
      
      protected var FTimeStrTextField:Vector.<TextField>;
      
      protected var FDecStrTextField:Vector.<TextField>;
      
      protected var FBtn_Close:SimpleButton;
      
      public function TProcessorUndertownFightingLog(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FTimeStrTextField = new Vector.<TextField>(FOUR);
         this.FDecStrTextField = new Vector.<TextField>(FOUR);
         this.TimeStr = new Vector.<String>();
         this.DecStr = new Vector.<String>();
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_UndertownFightingLog") as Sprite;
         this.FMainUI.x = (FUICore.StageWidth - this.FMainUI.width) / 2;
         this.FMainUI.y = (FUICore.StageHeight - this.FMainUI.height) / 2;
         addChild(this.FMainUI);
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < FOUR)
         {
            this.FTimeStrTextField[_loc4_] = this.FMainUI["TF_Time_" + _loc4_];
            this.FDecStrTextField[_loc4_] = this.FMainUI["TF_Value_" + _loc4_];
            _loc4_++;
         }
         this.FBtn_Close = this.FMainUI["Btn_Close"];
         this.FUIPage.ButtonPrevious.Substrate = this.FMainUI["MC_ChangePage"]["MC_PageLeft"];
         this.FUIPage.ButtonNext.Substrate = this.FMainUI["MC_ChangePage"]["MC_PageRight"];
         this.FUIPage.LabelPage = this.FMainUI["MC_ChangePage"]["TF_Page"];
         this.FUIPage.PageSize = FOUR;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.BtnClick);
         super.ResourcesPerform_UILocations();
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         this.Visible = false;
         SLogicsCore.UndertownLogicData.NextWillOpenPanelIndex = 0;
      }
      
      public function SetDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:Date = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:TDungeonsPractise = null;
         this.TimeStr.length = 0;
         this.DecStr.length = 0;
         _loc2_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = int(param1.readUnsignedByte());
            _loc6_ = int(param1.readUnsignedByte());
            _loc7_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = TUtilityString.FetchUTF(param1);
            _loc10_ = new Date(STimingCore.GetClientShowTime(_loc8_) * 1000);
            _loc12_ = TUtilityDate.FormatDateChineseNew(_loc10_);
            this.TimeStr.push(_loc12_);
            _loc13_ = SLogicsCore.UndertownLogicData.DungeonsPractiseBin.GetDatebaseByIdentifier(_loc7_) as TDungeonsPractise;
            if(_loc5_ == 0)
            {
               if(_loc6_)
               {
                  _loc11_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_7).DescribeString,_loc9_,_loc13_.CampaignName);
               }
               else
               {
                  _loc11_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_6).DescribeString,_loc9_);
               }
            }
            else if(_loc6_)
            {
               _loc11_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_8).DescribeString,_loc9_);
            }
            else
            {
               _loc11_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_9).DescribeString,_loc9_);
            }
            this.DecStr.push(_loc11_);
            _loc3_++;
         }
         this.FUIPage.TotalQuantity = this.TimeStr.length;
         this.FUIPage.Update();
         this.ReflashView();
      }
      
      public function ReflashView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            _loc2_ = _loc1_ + this.FCurPage * FOUR;
            if(_loc2_ >= this.TimeStr.length)
            {
               this.FTimeStrTextField[_loc1_].text = "";
               this.FDecStrTextField[_loc1_].text = "";
            }
            else
            {
               this.FTimeStrTextField[_loc1_].text = this.TimeStr[_loc2_];
               this.FDecStrTextField[_loc1_].text = this.DecStr[_loc2_];
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.ReflashView();
      }
   }
}

