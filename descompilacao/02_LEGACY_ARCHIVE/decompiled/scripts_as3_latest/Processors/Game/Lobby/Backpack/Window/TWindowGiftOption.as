package Processors.Game.Lobby.Backpack.Window
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TItemAward;
   import Logics.DatebaseVO.VO.TItemBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import ghostcat.util.data.Json;
   
   public class TWindowGiftOption extends TUIComponent
   {
      
      protected var FUIShowItem:TUIShowItem;
      
      protected var FInventories:TInventories;
      
      protected var FCurrInventory:TInventory;
      
      protected var FTotalOptNum:int;
      
      protected var FCurOptNum:int;
      
      protected var FMaxCount:int;
      
      protected var FCurCount:int;
      
      protected var FOptIndexs:Object = {};
      
      protected var MainUI:MovieClip;
      
      protected var FBTN_Confirm:MovieClip;
      
      protected var FOnEffectGenerateText:Function;
      
      protected var FSlotsOnOver:Function;
      
      protected var FSlotsOnOut:Function;
      
      protected var FOnOK:Function;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TWindowGiftOption(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
         this.InitView();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      protected function InitView() : void
      {
         this.MainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_PopupGift") as MovieClip;
         this.addChild(this.MainUI);
         this.FUIShowItem = new TUIShowItem(this,8);
         this.FUIShowItem.Perform_UIDispatch(this.MainUI["MC_Main"]["MC_ShowItems"]);
         this.FUIShowItem.OnOverlay = this.OnSlotsOnOver;
         this.FUIShowItem.OnOut = this.OnSlotsOnOut;
         TGameUtil.setButtonMode(this.MainUI["btn_Max"],true);
         this.MainUI["btn_Max"].addEventListener(MouseEvent.CLICK,this.OnMaxClick);
         this.MainUI["BTN_Confirm"].addEventListener(MouseEvent.CLICK,this.OnConfirmClick);
         this.MainUI["TF_GoodsNum"].addEventListener(Event.CHANGE,this.OnTextChange);
         this.MainUI["btn_close"].addEventListener(MouseEvent.CLICK,this.OnbtnClose);
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            this.MainUI["Mc_opt_" + _loc1_].addEventListener(MouseEvent.CLICK,this.OnclickOption);
            _loc1_++;
         }
         this.SetOptionCheck(false);
         this.x = FUICore.StageWidth - this.MainUI.width >> 1;
         this.y = FUICore.StageHeight - this.MainUI.height >> 1;
      }
      
      public function UpdateUI(param1:TInventory) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         var _loc5_:uint = 0;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:Object = null;
         var _loc11_:TBins = null;
         var _loc12_:TItemAward = null;
         var _loc13_:TBins = null;
         var _loc14_:TItemBox = null;
         this.FCurrInventory = param1;
         _loc6_ = new Vector.<uint>();
         _loc7_ = new Vector.<uint>();
         this.FInventories = new TInventories();
         _loc11_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc13_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ItemBox);
         _loc14_ = _loc13_.GetDatebaseByValue("ArticleId",param1.IDTemplate) as TItemBox;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ItemAward,_loc14_.Reward) as TItemAward;
         _loc2_ = int(_loc12_.SperewardArr.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc10_ = _loc12_.SperewardArr[_loc3_];
            _loc9_ = uint(_loc10_.type);
            _loc8_ = uint(_loc10_.code);
            _loc5_ = CONST_COMMON.GetItemIDByType(_loc9_,_loc8_,_loc11_);
            _loc6_.push(_loc5_);
            _loc7_.push(_loc10_.amount);
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc6_);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FInventories.GetInventoryByIndex(_loc3_);
            _loc4_.Quantity = _loc7_[_loc3_];
            _loc3_++;
         }
         this.FUIShowItem.UpdateUI(this.FInventories);
         this.MainUI["TF_Optnum"].text = this.FTotalOptNum = _loc12_.RewardNum;
         this.FMaxCount = param1.Quantity;
         this.OnMaxClick();
         this.UpdateBtnStyle();
      }
      
      public function LogicsPerform() : void
      {
         if(this.FUIShowItem)
         {
            this.FUIShowItem.LogicsPerform();
         }
      }
      
      protected function SetOptionCheck(param1:Boolean, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         _loc5_ = this.MainUI["Mc_opt_" + param2];
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc4_ = this.MainUI["Mc_opt_" + _loc3_];
            if(!_loc5_ || _loc4_ == _loc5_)
            {
               if(param1)
               {
                  _loc4_.gotoAndStop("ok");
               }
               else
               {
                  _loc4_.gotoAndStop("cancle");
               }
            }
            _loc3_++;
         }
      }
      
      protected function UpdateBtnStyle() : void
      {
         if(this.FCurOptNum >= this.FTotalOptNum)
         {
            TGameUtil.setButtonMode(this.MainUI["BTN_Confirm"],true);
            this.MainUI["BTN_Confirm"].mouseEnabled = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.MainUI["BTN_Confirm"],false);
            this.MainUI["BTN_Confirm"].mouseEnabled = false;
         }
      }
      
      protected function OnSlotsOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FSlotsOnOver != null)
         {
            this.FSlotsOnOver(param1,param2);
         }
      }
      
      protected function OnSlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FSlotsOnOut != null)
         {
            this.FSlotsOnOut(param1,param2);
         }
      }
      
      protected function OnclickOption(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:String = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = _loc2_.name.substr(-1);
         if(_loc2_.currentLabel == "ok")
         {
            this.SetOptionCheck(false,int(_loc3_));
            delete this.FOptIndexs[_loc3_];
            --this.FCurOptNum;
         }
         else if(this.IsCheckOptEnabled(int(_loc3_)))
         {
            this.SetOptionCheck(true,int(_loc3_));
            this.FOptIndexs[_loc3_] = _loc3_;
            ++this.FCurOptNum;
         }
         this.UpdateBtnStyle();
      }
      
      protected function IsCheckOptEnabled(param1:int) : Boolean
      {
         if(this.FCurOptNum >= this.FTotalOptNum)
         {
            this.FOnEffectGenerateText(this,TUtilityString.GetText(CONST_SYSTEMLANGUAGE.BACKPACK_STRING_11));
            return false;
         }
         if(Boolean(this.FInventories) && param1 >= this.FInventories.Count)
         {
            return false;
         }
         return true;
      }
      
      protected function OnConfirmClick(param1:MouseEvent) : void
      {
         if(this.FOnOK != null)
         {
            this.FOnOK(this,this.FCurrInventory,this.FCurCount,Json.encode(this.FOptIndexs));
         }
         this.OnbtnClose(null);
      }
      
      protected function OnMaxClick(param1:MouseEvent = null) : void
      {
         this.FCurCount = this.FMaxCount;
         this.MainUI["TF_GoodsNum"].text = this.FCurCount;
      }
      
      protected function OnTextChange(param1:Event) : void
      {
         this.FCurCount = int(this.MainUI["TF_GoodsNum"].text);
         if(this.FCurCount > this.FMaxCount)
         {
            this.FCurCount = this.FMaxCount;
         }
         if(this.FCurCount < 1)
         {
            this.FCurCount = 1;
         }
         this.MainUI["TF_GoodsNum"].text = this.FCurCount;
      }
      
      protected function OnbtnClose(param1:MouseEvent) : void
      {
         Visible = false;
         this.SetOptionCheck(false);
         this.FCurOptNum = 0;
         this.FOptIndexs = {};
      }
      
      public function get OnEffectGenerateText() : Function
      {
         return this.FOnEffectGenerateText;
      }
      
      public function set OnEffectGenerateText(param1:Function) : void
      {
         this.FOnEffectGenerateText = param1;
      }
      
      public function get SlotsOnOver() : Function
      {
         return this.FSlotsOnOver;
      }
      
      public function set SlotsOnOver(param1:Function) : void
      {
         this.FSlotsOnOver = param1;
      }
      
      public function get SlotsOnOut() : Function
      {
         return this.FSlotsOnOut;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      public function get OnOK() : Function
      {
         return this.FOnOK;
      }
      
      public function set OnOK(param1:Function) : void
      {
         this.FOnOK = param1;
      }
   }
}

