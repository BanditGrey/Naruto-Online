package Processors.Game.Lobby.GiftBag
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUIButton;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.Inventories.TInventories;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.GiftBag.Component.TUISevenDayGiftBagBox;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_BACKPACK;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_GIFTBAG;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowSevenDayGift extends TProcessorLobbyWindow
   {
      
      protected static const GIFTBAG_AWARDID_FIRSTDAY:uint = 400013;
      
      protected static const GIFTBAG_AWARDID_SECONDDAY:uint = 400014;
      
      protected static const GIFTBAG_AWARDID_THIRDDAY:uint = 400015;
      
      protected static const GIFTBAG_AWARDID_FOURDAY:uint = 400016;
      
      protected static const GIFTBAG_AWARDID_FIVEDAY:uint = 400017;
      
      protected static const GIFTBAG_AWARDID_SIXDAY:uint = 400018;
      
      protected static const GIFTBAG_AWARDID_SEVENDAY:uint = 400019;
      
      protected static const GETAWARD_ID:Vector.<uint> = Vector.<uint>([GIFTBAG_AWARDID_FIRSTDAY,GIFTBAG_AWARDID_SECONDDAY,GIFTBAG_AWARDID_THIRDDAY,GIFTBAG_AWARDID_FOURDAY,GIFTBAG_AWARDID_FIVEDAY,GIFTBAG_AWARDID_SIXDAY,GIFTBAG_AWARDID_SEVENDAY]);
      
      protected static const SEVENDAYBAG_BOXCOUNT:uint = 7;
      
      protected static const SEVENDAYBAG_PAGEBOXCOUNT:uint = 4;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FCurrentCapacity:int;
      
      protected var FBackpackCapacity:int;
      
      protected var FMC:Sprite;
      
      protected var FMC_Box:TUISevenDayGiftBagBox;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_LoginDay:Sprite;
      
      protected var FBtn_Look:MovieClip;
      
      protected var FBoxSlot:Vector.<TUISevenDayGiftBagBox>;
      
      protected var FInventories:Vector.<TInventories>;
      
      protected var FSevenDayAtom:Vector.<TActivityAtom>;
      
      protected var FIsOpen:Boolean;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FUIPage:TUIPage;
      
      protected var FButtonPrevious:TUIButton;
      
      protected var FButtonNext:TUIButton;
      
      protected var FCloseOnClick:Function;
      
      protected var FGetAwardOnClick:Function;
      
      protected var FBoxSlotOnOver:Function;
      
      protected var FBoxSlotOnOut:Function;
      
      protected var FSevenDayAtoms:TActivityAtoms;
      
      public function TProcessorWindowSevenDayGift(param1:TUIComponent)
      {
         super(param1);
         this.FBoxSlot = new Vector.<TUISevenDayGiftBagBox>();
         this.FSevenDayAtom = new Vector.<TActivityAtom>();
         this.FInventories = new Vector.<TInventories>();
         this.FUIPage = new TUIPage(this);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.x = CONST_COMMON.STAGE_Width - 400 >> 1;
         this.FProcessorWindowRecruit.y = CONST_COMMON.STAGE_Height - 367 >> 1;
         this.FProcessorWindowRecruit.HintOnOver = this.TipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.TipOnOut;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GIFTBAG.RESOURCESID_SWF_GIFTBAG);
         this.FProcessorWindowRecruit.Load();
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUISevenDayGiftBagBox = null;
         var _loc5_:MovieClip = null;
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_GIFTBAG.RESOURCE_ClassName_SevenDayGift) as Sprite;
         addChild(this.FMC);
         this.FBTN_Close = this.FMC[CONST_GIFTBAG.RESOURCE_Link_BTN_Close];
         _loc1_ = 0;
         while(_loc1_ < SEVENDAYBAG_BOXCOUNT)
         {
            _loc3_ = this.FMC[CONST_GIFTBAG.RESOURCE_Link_MC_LoginDay + _loc1_];
            _loc4_ = new TUISevenDayGiftBagBox(this);
            _loc4_.Perform_UIDispatch(_loc3_);
            _loc4_.SlotOnMove = this.OnBoxSlotOnMove;
            _loc4_.SlotOnOut = this.OnBoxSlotOnOut;
            _loc4_.GetAwardOnClick = this.OnGetAwardClick;
            _loc4_.OnTipOver = this.OnAwardTipOver;
            _loc4_.OnTipOut = this.OnAwardTipOut;
            _loc4_.BoxIndex = _loc1_;
            this.FBoxSlot[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc5_ = this.FMC[CONST_BACKPACK.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = this.FMC[CONST_BACKPACK.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         this.FUIPage.PageSize = SEVENDAYBAG_PAGEBOXCOUNT;
         this.FUIPage.TotalQuantity = SEVENDAYBAG_BOXCOUNT;
         this.FUIPage.Init();
         this.FButtonPrevious = this.FUIPage.ButtonPrevious;
         this.FButtonNext = this.FUIPage.ButtonNext;
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseClick);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         _loc2_ = int(SEVENDAYBAG_BOXCOUNT);
         if(this.FInventories.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(this.FBoxSlot.length > 0)
               {
                  this.FBoxSlot[_loc1_].UpDataSlots(this,this.FInventories[_loc1_]);
               }
               _loc1_++;
            }
         }
         this.FUIPage.OnChangePage = this.PageOnChange;
         if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
         {
            this.FProcessorWindowRecruit.UpdataBitmap();
         }
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISevenDayGiftBagBox = null;
         _loc2_ = int(SEVENDAYBAG_BOXCOUNT);
         if(this.FBoxSlot.length <= 0)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBoxSlot[_loc1_];
            _loc3_.GetAwardStatus = this.FSevenDayAtom[_loc1_].ActiveStatus;
            _loc3_.UpDataSlots(this,this.FInventories[_loc1_]);
            if(_loc1_ >= this.FPageIndex * SEVENDAYBAG_PAGEBOXCOUNT && _loc1_ < (this.FPageIndex + 1) * SEVENDAYBAG_PAGEBOXCOUNT)
            {
               _loc3_.SetMCVisble(true);
            }
            else
            {
               _loc3_.SetMCVisble(false);
            }
            _loc1_++;
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateUI();
      }
      
      protected function SetMode() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         if(this.FSevenDayAtoms == null)
         {
            return;
         }
         this.FIsOpen = this.FSevenDayAtoms.IsOn;
         _loc1_ = this.FSevenDayAtoms.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FSevenDayAtom[_loc2_] = this.FSevenDayAtoms.GetActivityAtomByIndex(_loc2_);
            _loc2_++;
         }
         this.FSevenDayAtom.sort(this.SortOnAtom);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FInventories[_loc2_] = this.FSevenDayAtom[_loc2_].InventoriesVect[0];
            _loc2_++;
         }
      }
      
      protected function SortOnAtom(param1:TActivityAtom, param2:TActivityAtom) : Number
      {
         if(param1.Sort < param2.Sort)
         {
            return -1;
         }
         if(param1.Sort > param2.Sort)
         {
            return 1;
         }
         return 0;
      }
      
      protected function OnCloseClick(param1:MouseEvent) : void
      {
         if(this.FCloseOnClick != null)
         {
            this.FCloseOnClick(this);
         }
      }
      
      protected function OnGetAwardClick(param1:Object, param2:uint) : void
      {
         var _loc3_:uint = 0;
         _loc3_ = GETAWARD_ID[param2];
         if(this.FGetAwardOnClick != null)
         {
            this.FGetAwardOnClick(param1,_loc3_);
         }
      }
      
      protected function OnBoxSlotOnMove(param1:Object, param2:Object) : void
      {
         if(this.FBoxSlotOnOver != null)
         {
            this.FBoxSlotOnOver(param1,param2);
         }
      }
      
      protected function OnBoxSlotOnOut(param1:Object, param2:Object) : void
      {
         if(this.FBoxSlotOnOut != null)
         {
            this.FBoxSlotOnOut(param1,param2);
         }
      }
      
      protected function OnLookHero(param1:MouseEvent) : void
      {
         this.FProcessorWindowRecruit.SetHeroData(11200004);
      }
      
      protected function TipOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function TipOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      private function OnAwardTipOut(param1:Object, param2:int) : void
      {
         var _loc3_:THint = null;
         _loc3_ = new THint();
         _loc3_.Caption = this.FSevenDayAtom[param2].Tips[0];
         this.FOverlayerHint.Context = _loc3_;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      private function OnAwardTipOver(param1:Object, param2:int) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      public function get CloseOnClick() : Function
      {
         return this.FCloseOnClick;
      }
      
      public function set CloseOnClick(param1:Function) : void
      {
         this.FCloseOnClick = param1;
      }
      
      public function get GetAwardOnClick() : Function
      {
         return this.FGetAwardOnClick;
      }
      
      public function set GetAwardOnClick(param1:Function) : void
      {
         this.FGetAwardOnClick = param1;
      }
      
      public function get BoxSlotOnOver() : Function
      {
         return this.FBoxSlotOnOver;
      }
      
      public function set BoxSlotOnOver(param1:Function) : void
      {
         this.FBoxSlotOnOver = param1;
      }
      
      public function get BoxSlotOnOut() : Function
      {
         return this.FBoxSlotOnOut;
      }
      
      public function set BoxSlotOnOut(param1:Function) : void
      {
         this.FBoxSlotOnOut = param1;
      }
      
      public function get SevenDayAtoms() : TActivityAtoms
      {
         return this.FSevenDayAtoms;
      }
      
      public function set SevenDayAtoms(param1:TActivityAtoms) : void
      {
         this.FSevenDayAtoms = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(param1 == false && this.FProcessorWindowRecruit != null)
         {
            this.FProcessorWindowRecruit.Visible = false;
         }
      }
      
      public function UpDateUI() : void
      {
         this.SetMode();
         this.UpdateUI();
         this.FUIPage.Update();
      }
   }
}

