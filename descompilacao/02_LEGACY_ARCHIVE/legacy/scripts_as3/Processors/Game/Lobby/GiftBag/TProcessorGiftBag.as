package Processors.Game.Lobby.GiftBag
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.ActivityMode.*;
   import Logics.Inventories.*;
   import Logics.Signals.*;
   import Logics.TimeCoolDown.TTimeCoolDown;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Overlayers.*;
   import flash.utils.*;
   
   public class TProcessorGiftBag extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WindowFirstDayBag_Width:Number = 450;
      
      protected static const SIZE_WindowFirstDayBag_Height:Number = 398;
      
      protected static const SIZE_WindowSevenDayBag_Width:Number = 900;
      
      protected static const SIZE_WindowSevenDayBag_Height:Number = 549;
      
      protected static const SIZE_WindowLevelGift_Width:Number = 900;
      
      protected static const SIZE_WindowLevelGift_Height:Number = 549;
      
      protected static const SIZE_WindowCollectGame_Width:Number = 595;
      
      protected static const SIZE_WindowCollectGame_Height:Number = 368;
      
      protected static const MAJOR_ACTIVEID_Online:uint = 1;
      
      protected static const MAJOR_ACTIVEID_Gold:uint = 2;
      
      protected static const MAJOR_ACTIVEID_FirstDay:uint = 3;
      
      protected static const MAJOR_ACTIVEID_SevenDay:uint = 4;
      
      protected static const MAJOR_ACTIVEID_HFReward:uint = 5;
      
      protected static const MAJOR_ACTIVEID_LevelGift:uint = 6;
      
      protected static const MAJOR_ACTIVEID_Collect:uint = 7;
      
      protected static const MINOR_ACTIVEID_Online:Vector.<uint> = Vector.<uint>([400001,400002,400003,400004,400005,400006,400007,400008]);
      
      protected static const MINOR_ACTIVEID_Gold:Vector.<uint> = Vector.<uint>([400009,400010,400011]);
      
      protected static const MINOR_ACTIVEID_FirstDay:uint = 400012;
      
      protected static const MINOR_ACTIVEID_SevenDay:Vector.<uint> = Vector.<uint>([400013,400014,400015,400016,400017,400018,400019]);
      
      protected static const MINOR_ACTIVEID_HFReward:uint = 400020;
      
      protected static const MINOR_ACTIVEID_CollectGame:uint = 425001;
      
      public static const SIGNALDESTINATION_ACTIVE_GiftBag_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_GiftBag_Ret;
      
      public static const KEY_Activity_OnLineGiftBag:uint = CONST_ACTIVITY_MODE.Activity_OnLineGiftBag;
      
      public static const KEY_Activity_GoldGiftBag:uint = CONST_ACTIVITY_MODE.Activity_GoldGiftBag;
      
      public static const KEY_Activity_FirstDayGiftBag:uint = CONST_ACTIVITY_MODE.Activity_FirstDayGiftBag;
      
      public static const KEY_Activity_7DayGiftBag:uint = CONST_ACTIVITY_MODE.Activity_7DayGiftBag;
      
      public static const KEY_Activity_HFReward:uint = CONST_ACTIVITY_MODE.Activity_HFReward;
      
      public static const ACTIVITY_LEVELGIFT:uint = CONST_ACTIVITY_MODE.ACTIVITY_LEVELGIFT;
      
      public static const ACTIVITY_COLLECTGAME:uint = CONST_ACTIVITY_MODE.ACTIVITY_COLLECTGAME;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const GIFT_BAG_COUNT:int = 7;
      
      protected var FProcessorWindowFirstDay:TProcessorWindowFirstDayGift;
      
      protected var FProcessorWindowSevenDay:TProcessorWindowSevenDayGift;
      
      protected var FProcessorWindowHFReward:TProcessorWindowFirstDayGift;
      
      protected var FProcessorWindowLevelGift:TProcessorWindowLevelGift;
      
      protected var FProcessorWindowCollectGame:TProcessorWindowCollectGame;
      
      protected var FWindowFirstDayBagBounds:TBounds;
      
      protected var FWindowSevenDayBagBounds:TBounds;
      
      protected var FWindowLevelGiftBounds:TBounds;
      
      protected var FWindowCollectGameBounds:TBounds;
      
      protected var FBInit:Boolean;
      
      protected var FFirstDayAtoms:TActivityAtoms;
      
      protected var FSevenDayAtoms:TActivityAtoms;
      
      protected var FOnlineAtoms:TActivityAtoms;
      
      protected var FGoldAtoms:TActivityAtoms;
      
      protected var FHFRewardAtoms:TActivityAtoms;
      
      protected var FLevelGiftAtoms:TActivityAtoms;
      
      protected var FCollectGameAtoms:TActivityAtoms;
      
      protected var FGoldStatus:Vector.<int>;
      
      protected var FOnlineStauts:Vector.<int>;
      
      protected var FOnlineIndex:int;
      
      protected var FGoldIndex:int;
      
      protected var FOnlineCoolingDown:TTimeCoolDown;
      
      protected var FChangedOnlineStatus:Boolean;
      
      protected var FBFirstShortcutStatus:Vector.<uint>;
      
      protected var FOnlineAward:String;
      
      protected var FCurOnlineAwardTip:String;
      
      protected var FNextOnlineAwardTip:String;
      
      protected var FGoldISGotoVip:Boolean;
      
      protected var FMajorActiveID:uint;
      
      protected var FShortcutEffectNotification:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      public function TProcessorGiftBag(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowFirstDay = new TProcessorWindowFirstDayGift(this,0);
         this.FProcessorWindowFirstDay.GetFirstDayAward = this.OnGetGiftBagAward;
         this.FProcessorWindowFirstDay.SlotOnMove = this.OnSlotMove;
         this.FProcessorWindowFirstDay.SlotOnOut = this.OnSlotOut;
         this.FProcessorWindowFirstDay.CloseOnClick = this.OnProcessorWindowClose;
         this.FProcessorWindowSevenDay = new TProcessorWindowSevenDayGift(this);
         this.FProcessorWindowSevenDay.GetAwardOnClick = this.OnGetGiftBagAward;
         this.FProcessorWindowSevenDay.BoxSlotOnOver = this.OnSlotMove;
         this.FProcessorWindowSevenDay.BoxSlotOnOut = this.OnSlotOut;
         this.FProcessorWindowSevenDay.CloseOnClick = this.OnProcessorWindowClose;
         this.FProcessorWindowHFReward = new TProcessorWindowFirstDayGift(this,1);
         this.FProcessorWindowHFReward.GetFirstDayAward = this.OnGetGiftBagAward;
         this.FProcessorWindowHFReward.SlotOnMove = this.OnSlotMove;
         this.FProcessorWindowHFReward.SlotOnOut = this.OnSlotOut;
         this.FProcessorWindowHFReward.CloseOnClick = this.OnProcessorWindowClose;
         this.FProcessorWindowLevelGift = new TProcessorWindowLevelGift(this);
         this.FProcessorWindowLevelGift.GetAwardOnClick = this.OnGetGiftBagAward;
         this.FProcessorWindowLevelGift.BoxSlotOnOver = this.OnSlotMove;
         this.FProcessorWindowLevelGift.BoxSlotOnOut = this.OnSlotOut;
         this.FProcessorWindowLevelGift.CloseOnClick = this.OnProcessorWindowClose;
         this.FProcessorWindowCollectGame = new TProcessorWindowCollectGame(this);
         this.FProcessorWindowCollectGame.GetAwardOnClick = this.OnGetGiftBagAward;
         this.FProcessorWindowCollectGame.SlotOnMove = this.OnSlotMove;
         this.FProcessorWindowCollectGame.SlotOnOut = this.OnSlotOut;
         this.FProcessorWindowCollectGame.CloseOnClick = this.OnProcessorWindowClose;
         this.FWindowFirstDayBagBounds = new TBounds();
         this.FWindowSevenDayBagBounds = new TBounds();
         this.FWindowLevelGiftBounds = new TBounds();
         this.FWindowCollectGameBounds = new TBounds();
         this.FWindowFirstDayBagBounds.Width = SIZE_WindowFirstDayBag_Width;
         this.FWindowFirstDayBagBounds.Height = SIZE_WindowFirstDayBag_Height;
         ComponentBoundsCenter(this.FProcessorWindowFirstDay,this.FWindowFirstDayBagBounds);
         this.FWindowSevenDayBagBounds.Width = SIZE_WindowSevenDayBag_Width;
         this.FWindowSevenDayBagBounds.Height = SIZE_WindowSevenDayBag_Height;
         ComponentBoundsCenter(this.FProcessorWindowSevenDay,this.FWindowSevenDayBagBounds);
         ComponentBoundsCenter(this.FProcessorWindowHFReward,this.FWindowFirstDayBagBounds);
         this.FWindowLevelGiftBounds.Width = SIZE_WindowLevelGift_Width;
         this.FWindowLevelGiftBounds.Height = SIZE_WindowLevelGift_Height;
         ComponentBoundsCenter(this.FProcessorWindowLevelGift,this.FWindowLevelGiftBounds);
         this.FWindowCollectGameBounds.Width = SIZE_WindowCollectGame_Width;
         this.FWindowCollectGameBounds.Height = SIZE_WindowCollectGame_Height;
         ComponentBoundsCenter(this.FProcessorWindowCollectGame,this.FWindowCollectGameBounds);
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_GiftBag);
         FOverlayerTreasure.Visible = false;
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_GiftBag);
         FOverlayerEquipment.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_GiftBag);
         FOverlayerAppliance.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_GiftBag);
         FOverlayerAccessory.Visible = false;
         this.FOnlineCoolingDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_Activity_OnlineGiftBag);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FOnlineCoolingDown);
         this.FBFirstShortcutStatus = new Vector.<uint>(GIFT_BAG_COUNT);
         this.FGoldISGotoVip = false;
         this.FBInit = false;
         SetUIModuleID(CONST_MODULES.MODULE_GiftBag);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GIFTBAG.RESOURCESID_SWF_GIFTBAG);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FOnlineCoolingDown.TimingTime <= 0 && this.FChangedOnlineStatus)
         {
            this.UpdataOnlineAtomsStatus();
         }
         if(this.FOnlineCoolingDown.TimingTime <= 0)
         {
            if(this.FOnlineAtoms != null)
            {
               this.FOnlineAtoms.GetActivityAtomByIndex(this.FOnlineIndex).Tips[0] = STRING_COMMON.STRING_CanReward + this.FOnlineAward;
            }
         }
         else if(this.FOnlineAtoms != null)
         {
            this.FOnlineAtoms.GetActivityAtomByIndex(this.FOnlineIndex).Tips[0] = STRING_COMMON.STRING_NextCanReward + this.FOnlineAward;
         }
         this.LogicsPerform_Signals();
      }
      
      protected function UpdataOnlineAtomsStatus() : void
      {
         this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_OnLineGiftBag,true);
         this.FBFirstShortcutStatus[0] = 1;
         this.FChangedOnlineStatus = false;
         if(this.FBFirstShortcutStatus.indexOf(1) == -1)
         {
            this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_ReceivePacks,false);
         }
         else
         {
            this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_ReceivePacks,true);
         }
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtoms = null;
         _loc1_ = SLogicsCore.SignalRetrieve(SIGNALDESTINATION_ACTIVE_GiftBag_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = _loc1_.UserData as TActivityAtoms;
         if(_loc3_ != null)
         {
            _loc3_.SortActivityAtoms();
         }
         switch(_loc2_)
         {
            case KEY_Activity_OnLineGiftBag:
               if(_loc3_ != null)
               {
                  this.CheckGiftBag(KEY_Activity_OnLineGiftBag,_loc3_);
                  if(this.FOnlineAtoms.IsOn)
                  {
                     this.SetOnlineGiftBagData(this.FOnlineAtoms);
                  }
               }
               break;
            case KEY_Activity_GoldGiftBag:
               if(_loc3_ != null)
               {
                  if(this.FGoldISGotoVip)
                  {
                     this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Avatar,CONST_SHORTCUTS.TYPE_Avatar_VIP);
                     this.FGoldISGotoVip = false;
                  }
                  this.CheckGiftBag(KEY_Activity_GoldGiftBag,_loc3_);
                  if(this.FGoldAtoms.IsOn)
                  {
                     this.SetGoldGiftBagData(this.FGoldAtoms);
                  }
               }
               break;
            case KEY_Activity_FirstDayGiftBag:
               if(_loc3_ != null)
               {
                  this.CheckGiftBag(KEY_Activity_FirstDayGiftBag,_loc3_);
                  if(this.FFirstDayAtoms.IsOn)
                  {
                     this.FProcessorWindowFirstDay.FirstDayAtoms = this.FFirstDayAtoms;
                  }
               }
               break;
            case KEY_Activity_7DayGiftBag:
               if(_loc3_ != null)
               {
                  this.CheckGiftBag(KEY_Activity_7DayGiftBag,_loc3_);
                  if(this.FSevenDayAtoms.IsOn)
                  {
                     this.FProcessorWindowSevenDay.SevenDayAtoms = this.FSevenDayAtoms;
                  }
               }
               break;
            case KEY_Activity_HFReward:
               if(_loc3_ != null)
               {
                  this.CheckGiftBag(KEY_Activity_HFReward,_loc3_);
                  if(this.FHFRewardAtoms.IsOn)
                  {
                     this.FProcessorWindowHFReward.FirstDayAtoms = this.FHFRewardAtoms;
                  }
               }
               break;
            case ACTIVITY_LEVELGIFT:
               if(_loc3_ != null)
               {
                  this.CheckGiftBag(ACTIVITY_LEVELGIFT,_loc3_);
                  if(this.FLevelGiftAtoms.IsOn)
                  {
                     this.FProcessorWindowLevelGift.LevelGiftAtoms = this.FLevelGiftAtoms;
                  }
               }
               break;
            case ACTIVITY_COLLECTGAME:
               if(_loc3_ != null)
               {
                  this.CheckGiftBag(ACTIVITY_COLLECTGAME,_loc3_);
                  if(this.FCollectGameAtoms.IsOn)
                  {
                     this.FProcessorWindowCollectGame.CollectGame = this.FCollectGameAtoms;
                  }
               }
         }
         if(this.FBFirstShortcutStatus.indexOf(1) == -1)
         {
            this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_ReceivePacks,false);
         }
         else
         {
            this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_ReceivePacks,true);
         }
      }
      
      protected function CheckGiftBag(param1:uint, param2:TActivityAtoms) : void
      {
         var _loc3_:Vector.<int> = null;
         _loc3_ = new Vector.<int>();
         switch(param1)
         {
            case KEY_Activity_OnLineGiftBag:
               if(param2 != null)
               {
                  this.FOnlineAtoms = param2;
                  if(this.FOnlineAtoms.IsOn)
                  {
                     _loc3_ = this.GetGiftBagStatus(this.FOnlineAtoms);
                     if(_loc3_.indexOf(0) == -1 && _loc3_.indexOf(1) == -1)
                     {
                        this.FOnlineAtoms.IsOn = false;
                        this.FBFirstShortcutStatus[0] = 0;
                     }
                     if(this.FOnlineAtoms.IsOn)
                     {
                        if(_loc3_.indexOf(1) != -1)
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_OnLineGiftBag,true);
                           this.FBFirstShortcutStatus[0] = 1;
                        }
                        else
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_OnLineGiftBag,false);
                           this.FBFirstShortcutStatus[0] = 0;
                        }
                     }
                  }
               }
               break;
            case KEY_Activity_GoldGiftBag:
               if(param2 != null)
               {
                  this.FGoldAtoms = param2;
                  if(this.FGoldAtoms.IsOn)
                  {
                     _loc3_ = this.GetGiftBagStatus(this.FGoldAtoms);
                     if(_loc3_.indexOf(1) == -1)
                     {
                        this.FGoldAtoms.IsOn = false;
                        this.FBFirstShortcutStatus[1] = 0;
                     }
                     if(this.FGoldAtoms.IsOn)
                     {
                        if(_loc3_.indexOf(1) != -1)
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_GoldGiftBag,true);
                           this.FBFirstShortcutStatus[1] = 1;
                        }
                        else
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_GoldGiftBag,false);
                           this.FBFirstShortcutStatus[1] = 0;
                        }
                     }
                  }
               }
               break;
            case KEY_Activity_FirstDayGiftBag:
               if(param2 != null)
               {
                  this.FFirstDayAtoms = param2;
                  if(this.FFirstDayAtoms.IsOn)
                  {
                     _loc3_ = this.GetGiftBagStatus(this.FFirstDayAtoms);
                     if(_loc3_.indexOf(0) == -1 && _loc3_.indexOf(1) == -1)
                     {
                        this.FFirstDayAtoms.IsOn = false;
                        this.FBFirstShortcutStatus[2] = 0;
                     }
                     if(this.FFirstDayAtoms.IsOn)
                     {
                        if(_loc3_.indexOf(1) != -1)
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_FirstDayGiftBag,true);
                           this.FBFirstShortcutStatus[2] = 1;
                        }
                        else
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_FirstDayGiftBag,false);
                           this.FBFirstShortcutStatus[2] = 0;
                        }
                     }
                  }
               }
               break;
            case KEY_Activity_7DayGiftBag:
               if(param2 != null)
               {
                  this.FSevenDayAtoms = param2;
                  if(this.FSevenDayAtoms.IsOn)
                  {
                     _loc3_ = this.GetGiftBagStatus(this.FSevenDayAtoms);
                     if(_loc3_.indexOf(0) == -1 && _loc3_.indexOf(1) == -1)
                     {
                        this.FSevenDayAtoms.IsOn = false;
                        this.FBFirstShortcutStatus[3] = 0;
                     }
                     if(this.FSevenDayAtoms.IsOn)
                     {
                        if(_loc3_.indexOf(1) != -1)
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_7DayGiftBag,true);
                           this.FBFirstShortcutStatus[3] = 1;
                        }
                        else
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_7DayGiftBag,false);
                           this.FBFirstShortcutStatus[3] = 0;
                        }
                     }
                  }
               }
               break;
            case KEY_Activity_HFReward:
               if(param2 != null)
               {
                  this.FHFRewardAtoms = param2;
                  if(this.FHFRewardAtoms.IsOn)
                  {
                     _loc3_ = this.GetGiftBagStatus(this.FHFRewardAtoms);
                     if(_loc3_.indexOf(0) == -1 && _loc3_.indexOf(1) == -1)
                     {
                        this.FHFRewardAtoms.IsOn = false;
                        this.FBFirstShortcutStatus[4] = 0;
                     }
                     if(this.FHFRewardAtoms.IsOn)
                     {
                        if(_loc3_.indexOf(1) != -1)
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_HFReward,true);
                           this.FBFirstShortcutStatus[4] = 1;
                        }
                        else
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_HFReward,false);
                           this.FBFirstShortcutStatus[4] = 0;
                        }
                     }
                  }
               }
               break;
            case ACTIVITY_LEVELGIFT:
               if(param2 != null)
               {
                  this.FLevelGiftAtoms = param2;
                  if(this.FLevelGiftAtoms.IsOn)
                  {
                     _loc3_ = this.GetGiftBagStatus(this.FLevelGiftAtoms);
                     if(_loc3_.indexOf(0) == -1 && _loc3_.indexOf(1) == -1)
                     {
                        this.FLevelGiftAtoms.IsOn = false;
                        this.FBFirstShortcutStatus[5] = 0;
                     }
                     if(this.FLevelGiftAtoms.IsOn)
                     {
                        if(_loc3_.indexOf(1) != -1)
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_LevelGift,true);
                           this.FBFirstShortcutStatus[5] = 1;
                        }
                        else
                        {
                           this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_LevelGift,false);
                           this.FBFirstShortcutStatus[5] = 0;
                        }
                     }
                  }
               }
               break;
            case ACTIVITY_COLLECTGAME:
               if(param2 != null)
               {
                  this.FCollectGameAtoms = param2;
                  if(this.FCollectGameAtoms.IsOn)
                  {
                     _loc3_ = this.GetGiftBagStatus(this.FCollectGameAtoms);
                     if(_loc3_.indexOf(0) == -1 && _loc3_.indexOf(1) == -1)
                     {
                        this.FCollectGameAtoms.IsOn = false;
                        this.FBFirstShortcutStatus[6] = 0;
                     }
                     if(_loc3_.indexOf(-1) < 0)
                     {
                        this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_CollectGame,true);
                        this.FBFirstShortcutStatus[6] = 1;
                     }
                     else
                     {
                        this.OnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_ActiveListSecondary,CONST_SHORTCUTS.TYPE_ActiveListSecondary_CollectGame,false);
                        this.FBFirstShortcutStatus[6] = 0;
                     }
                  }
               }
         }
      }
      
      protected function GetGiftBagStatus(param1:TActivityAtoms) : Vector.<int>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         var _loc5_:Vector.<TActivityAtom> = null;
         _loc3_ = param1.Count;
         _loc4_ = new Vector.<int>(_loc3_);
         _loc5_ = new Vector.<TActivityAtom>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_[_loc2_] = param1.GetActivityAtomByIndex(_loc2_);
            _loc4_[_loc2_] = _loc5_[_loc2_].ActiveStatus;
            _loc2_++;
         }
         return _loc4_;
      }
      
      protected function SetOnlineGiftBagData(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<TActivityAtom> = null;
         var _loc5_:Vector.<TInventories> = null;
         var _loc6_:Vector.<String> = null;
         var _loc7_:Vector.<Object> = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:TInventory = null;
         var _loc13_:TInventory = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         _loc3_ = this.FOnlineAtoms.Count;
         _loc4_ = new Vector.<TActivityAtom>(_loc3_);
         _loc5_ = new Vector.<TInventories>(_loc3_);
         _loc6_ = new Vector.<String>(_loc3_);
         _loc7_ = new Vector.<Object>(_loc3_);
         this.FOnlineStauts = new Vector.<int>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_[_loc2_] = this.FOnlineAtoms.GetActivityAtomByIndex(_loc2_);
            _loc2_++;
         }
         _loc4_.sort(this.SortOnAtoms);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FOnlineStauts[_loc2_] = _loc4_[_loc2_].ActiveStatus;
            _loc5_[_loc2_] = _loc4_[_loc2_].InventoriesVect[0];
            _loc6_[_loc2_] = _loc4_[_loc2_].Tips[0];
            _loc7_[_loc2_] = _loc4_[_loc2_].ConditionValue[0];
            _loc2_++;
         }
         if(this.FOnlineStauts.indexOf(1) != -1)
         {
            this.FOnlineIndex = this.FOnlineStauts.indexOf(1);
            this.FOnlineCoolingDown.TimingTime = 0;
         }
         else if(this.FOnlineStauts.indexOf(0) != -1)
         {
            this.FOnlineIndex = this.FOnlineStauts.indexOf(0);
            this.FOnlineCoolingDown.TimingTime = int(_loc7_[this.FOnlineIndex]);
            this.FChangedOnlineStatus = true;
         }
         _loc9_ = "";
         _loc3_ = _loc5_[this.FOnlineIndex].Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc13_ = _loc5_[this.FOnlineIndex].GetInventoryByIndex(_loc2_);
            _loc9_ += "\n" + _loc13_.Name + "*" + _loc13_.Quantity;
            this.FOnlineAward = _loc9_;
            _loc2_++;
         }
         _loc14_ = _loc6_[this.FOnlineIndex];
      }
      
      protected function OnlineGiftBagHandler() : void
      {
         if(this.FOnlineCoolingDown.TimingTime <= 0)
         {
            this.OnGetGiftBagAward(this,MINOR_ACTIVEID_Online[this.FOnlineIndex]);
            ProcessorClose();
         }
      }
      
      protected function SetGoldGiftBagData(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<TActivityAtom> = null;
         var _loc5_:Vector.<TInventories> = null;
         var _loc6_:Vector.<String> = null;
         var _loc7_:Vector.<Object> = null;
         this.FGoldAtoms = param1;
         if(this.FGoldAtoms == null)
         {
            return;
         }
         _loc3_ = this.FGoldAtoms.Count;
         _loc4_ = new Vector.<TActivityAtom>(_loc3_);
         this.FGoldStatus = new Vector.<int>(_loc3_);
         _loc5_ = new Vector.<TInventories>(_loc3_);
         _loc6_ = new Vector.<String>(_loc3_);
         _loc7_ = new Vector.<Object>(_loc3_);
         this.FGoldStatus = new Vector.<int>(_loc3_);
         this.FGoldIndex = -1;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_[_loc2_] = this.FGoldAtoms.GetActivityAtomByIndex(_loc2_);
            _loc2_++;
         }
         _loc4_.sort(this.SortOnAtoms);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FGoldStatus[_loc2_] = _loc4_[_loc2_].ActiveStatus;
            _loc6_[_loc2_] = _loc4_[_loc2_].Tips[0];
            _loc5_[_loc2_] = _loc4_[_loc2_].InventoriesVect[0];
            _loc7_[_loc2_] = int(_loc4_[_loc2_].ConditionValue[0]);
            _loc2_++;
         }
         this.FGoldIndex = this.FGoldStatus.indexOf(1);
         if(this.FGoldIndex != -1)
         {
            this.SetIconDataHandler(_loc4_,_loc5_,_loc7_,_loc6_,2,this.FGoldIndex);
         }
      }
      
      protected function SetIconDataHandler(param1:Vector.<TActivityAtom>, param2:Vector.<TInventories>, param3:Vector.<Object>, param4:Vector.<String>, param5:uint, param6:int = -1) : void
      {
         var _loc7_:TInventories = null;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:Vector.<TInventory> = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         if(param5 != 1)
         {
            if(param5 == 2)
            {
               _loc7_ = param2[param6];
               _loc12_ = _loc9_ = param4[param6];
               this.FGoldAtoms.GetActivityAtomByIndex(this.FGoldIndex).Tips[0] = _loc12_;
            }
         }
      }
      
      protected function SortOnAtoms(param1:TActivityAtom, param2:TActivityAtom) : Number
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
      
      protected function GetGoldAwardHandler() : void
      {
         this.FGoldISGotoVip = true;
         this.OnGetGiftBagAward(this,MINOR_ACTIVEID_Gold[this.FGoldIndex]);
         ProcessorClose();
      }
      
      protected function OnSlotMove(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = FOverlayerAccessory;
               break;
            default:
               _loc4_ = FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function OnSlotOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = FOverlayerAccessory;
               break;
            default:
               _loc4_ = FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function OnGetGiftBagAward(param1:Object, param2:Object) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc3_ = param2 as uint;
         if(_loc3_ <= 0)
         {
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ReceiveAwardsReq);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function OnProcessorWindowClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function OnShortcutEffectNotification(param1:uint, param2:uint, param3:Boolean) : void
      {
         if(this.FShortcutEffectNotification != null)
         {
            this.FShortcutEffectNotification(param1,param2,param3);
         }
      }
      
      public function get MajorActiveID() : uint
      {
         return this.FMajorActiveID;
      }
      
      public function set MajorActiveID(param1:uint) : void
      {
         this.FMajorActiveID = param1;
      }
      
      public function get ShortcutEffectNotification() : Function
      {
         return this.FShortcutEffectNotification;
      }
      
      public function set ShortcutEffectNotification(param1:Function) : void
      {
         this.FShortcutEffectNotification = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowFirstDay.Load();
            this.FProcessorWindowSevenDay.Load();
            this.FProcessorWindowHFReward.Load();
            this.FProcessorWindowLevelGift.Load();
            this.FProcessorWindowCollectGame.Load();
            return;
         }
         switch(this.FMajorActiveID)
         {
            case MAJOR_ACTIVEID_Online:
            case MAJOR_ACTIVEID_Gold:
               break;
            case MAJOR_ACTIVEID_FirstDay:
               this.FProcessorWindowFirstDay.Visible = true;
               this.FProcessorWindowFirstDay.UpDataUI();
               break;
            case MAJOR_ACTIVEID_SevenDay:
               this.FProcessorWindowSevenDay.Visible = true;
               this.FProcessorWindowSevenDay.UpDateUI();
               break;
            case MAJOR_ACTIVEID_HFReward:
               this.FProcessorWindowHFReward.Visible = true;
               this.FProcessorWindowHFReward.UpDataUI();
               break;
            case MAJOR_ACTIVEID_LevelGift:
               this.FProcessorWindowLevelGift.Visible = true;
               this.FProcessorWindowLevelGift.UpDateUI();
               break;
            case MAJOR_ACTIVEID_Collect:
               this.FProcessorWindowCollectGame.Visible = true;
               this.FProcessorWindowCollectGame.UpDataUI();
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FProcessorWindowFirstDay.Visible = false;
         this.FProcessorWindowSevenDay.Visible = false;
         this.FProcessorWindowHFReward.Visible = false;
         this.FProcessorWindowLevelGift.Visible = false;
         this.FProcessorWindowCollectGame.Visible = false;
         this.FMajorActiveID = 0;
      }
      
      public function OnGiftBagClick(param1:uint) : void
      {
         switch(param1)
         {
            case MAJOR_ACTIVEID_Online:
               this.OnlineGiftBagHandler();
               break;
            case MAJOR_ACTIVEID_Gold:
               this.GetGoldAwardHandler();
         }
      }
   }
}

