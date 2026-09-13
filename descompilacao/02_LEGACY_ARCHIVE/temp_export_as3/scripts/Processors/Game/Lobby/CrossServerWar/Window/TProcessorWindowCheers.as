package Processors.Game.Lobby.CrossServerWar.Window
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.CrossServerWar.TToastRecord;
   import Logics.CrossServerWar.TToastRecords;
   import Logics.DatebaseVO.VO.Json.TCrossServerWarReward;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TGSPVP_DailyAward;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.CrossServerWar.Components.TUICheers;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowCheers extends TProcessorLobbyWindow
   {
      
      protected const CAPACITY_Items:uint = 3;
      
      protected const CAPACITY_Texts:uint = 8;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FUICheers:Vector.<TUICheers>;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FToastTexts:Vector.<TextField>;
      
      protected var FToastRecords:TToastRecords;
      
      protected var FOnToastClick:Function;
      
      public function TProcessorWindowCheers(param1:TUIComponent)
      {
         super(param1);
         this.FUICheers = new Vector.<TUICheers>();
         this.FEliteRecord = SLogicsCore.EliteRecord;
         this.FToastTexts = new Vector.<TextField>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUICheers = null;
         TGameUtil.AddWindowMask(this);
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CROSSSERVERWAR.RESOURCE_ClassName_MC_Cheers) as Sprite;
         addChild(_loc1_);
         _loc1_.x = CONST_COMMON.STAGE_Width - _loc1_.width >> 1;
         _loc1_.y = CONST_COMMON.STAGE_Height - _loc1_.height >> 1;
         this.FBTN_Close = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Close];
         _loc3_ = this.CAPACITY_Items;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TUICheers(this);
            _loc4_.Resource = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Cheer + _loc2_];
            _loc4_.OnToastClick = this.ProcessorOnToastClick;
            _loc4_.Init();
            this.FUICheers[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc3_ = this.CAPACITY_Texts;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FToastTexts[_loc2_] = _loc1_["TF_Toast_" + _loc2_];
            this.FToastTexts[_loc2_].text = "";
            _loc2_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TBins = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TGSPVP_DailyAward = null;
         var _loc5_:TUICheers = null;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GSPVP_DailyAward) as TBins;
         _loc3_ = uint(_loc1_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc1_.GetDatebaseByIndex(_loc2_) as TGSPVP_DailyAward;
            _loc5_ = this.FUICheers[_loc2_];
            _loc5_.Context = _loc4_;
            _loc5_.Update();
            _loc2_++;
         }
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function UpdateToast() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUICheers = null;
         var _loc4_:Boolean = false;
         _loc4_ = this.FEliteRecord.ToastTimes <= 0;
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUICheers[_loc1_];
            _loc3_.UpdateBtnStatus(_loc4_);
            _loc1_++;
         }
      }
      
      protected function UpdateRecord() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         var _loc4_:String = null;
         var _loc5_:TToastRecord = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:TGSPVP_DailyAward = null;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:TCrossServerWarReward = null;
         var _loc12_:int = 0;
         var _loc13_:TArticle = null;
         if(this.FToastRecords != null)
         {
            _loc2_ = this.CAPACITY_Texts;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FToastTexts[_loc1_];
               _loc3_.visible = false;
               _loc1_++;
            }
            _loc2_ = this.CAPACITY_Texts;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(_loc1_ >= this.FToastRecords.Count)
               {
                  break;
               }
               _loc4_ = "";
               _loc3_ = this.FToastTexts[_loc1_];
               _loc5_ = this.FToastRecords.GetToastRecordByIndex(_loc1_);
               _loc6_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc5_.Quality];
               _loc7_ = _loc5_.Name;
               _loc4_ += this.MakeHtmlText(0,_loc6_,_loc7_);
               _loc7_ = STRING_CROSSSERVERWAR.STRING_Toast;
               _loc6_ = 0;
               _loc4_ += this.MakeHtmlText(1,_loc6_,_loc7_);
               _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_GSPVP_DailyAward,_loc5_.ToastID) as TGSPVP_DailyAward;
               _loc6_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc8_.Quality];
               _loc12_ = STRING_CROSSSERVERWAR.WineTypeVec.indexOf(_loc5_.ToastID);
               if(_loc12_ != -1)
               {
                  _loc7_ = STRING_CROSSSERVERWAR.WineNameVec[_loc12_];
               }
               _loc4_ += this.MakeHtmlText(0,_loc6_,_loc7_);
               _loc10_ = _loc8_.CrossServerWarRewards.length;
               _loc9_ = 0;
               while(_loc9_ < _loc10_)
               {
                  _loc11_ = _loc8_.CrossServerWarRewards[_loc9_];
                  _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc11_.Code) as TArticle;
                  if(_loc13_ != null)
                  {
                     _loc6_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc13_.Quality];
                     _loc7_ = _loc13_.Name;
                     _loc4_ += this.MakeHtmlText(0,_loc6_,_loc7_);
                     _loc4_ = _loc4_ + ("*" + _loc11_.Amount + " ");
                  }
                  else
                  {
                     _loc6_ = 0;
                     _loc7_ = STRING_COMMON.GetItemNameByType(_loc11_.Type,_loc11_.Code);
                     _loc4_ += this.MakeHtmlText(1,_loc6_,_loc7_);
                     _loc4_ = _loc4_ + ("+" + _loc11_.Amount + " ");
                  }
                  _loc9_++;
               }
               _loc3_.htmlText = _loc4_;
               _loc3_.visible = true;
               _loc1_++;
            }
         }
      }
      
      protected function MakeHtmlText(param1:uint, param2:uint, param3:String) : String
      {
         var _loc4_:String = null;
         if(param1 == 0)
         {
            return TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_QualityToastRecord,param2.toString(16),param3);
         }
         return TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_CommonToastRecord,param3);
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnToastClick(param1:Object, param2:Object) : void
      {
         if(this.FOnToastClick != null)
         {
            this.FOnToastClick(this,param2);
         }
      }
      
      public function get OnToastClick() : Function
      {
         return this.FOnToastClick;
      }
      
      public function set OnToastClick(param1:Function) : void
      {
         this.FOnToastClick = param1;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateToast();
      }
      
      public function UpdateToastRecord(param1:Object) : void
      {
         var _loc2_:TToastRecords = null;
         if(param1 is TToastRecords)
         {
            _loc2_ = param1 as TToastRecords;
            this.FToastRecords = _loc2_;
            this.UpdateRecord();
         }
      }
   }
}

