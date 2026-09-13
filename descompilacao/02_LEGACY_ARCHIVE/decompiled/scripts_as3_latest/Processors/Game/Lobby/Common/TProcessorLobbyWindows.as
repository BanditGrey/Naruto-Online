package Processors.Game.Lobby.Common
{
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.*;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Processors.Spaces.ProcessorSpace;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverSuperJade;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerMedal;
   import Rendering.Overlayers.Inventories.TOverlayerRing;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.*;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   use namespace ProcessorSpace;
   
   public class TProcessorLobbyWindows extends TProcessorLobbyModule
   {
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CATEGORY_Medal:uint = CONST_INVENTORY.CATEGORY_Medals;
      
      protected var FBuyBoxObj:Object;
      
      protected var FCurCost:int;
      
      protected var FIsClicked:Boolean;
      
      protected var FHtmlHint:THint;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerRing:TOverlayerRing;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FOverSuperJade:TOverSuperJade;
      
      protected var FOverlayerMedal:TOverlayerMedal;
      
      protected var FUIGoldConfirmation:TUIWindowConfirmation;
      
      protected var FUIGotoRecharge:TUIWindowRecharge;
      
      protected var FOnClose:Function;
      
      protected var FOnUpdatePopTipsModes:Function;
      
      protected var FOnCheckPopTipsModes:Function;
      
      public var CheckIconEffect:Function;
      
      public function TProcessorLobbyWindows(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FBuyBoxObj = new Object();
         this.FHtmlHint = new THint();
         this.FUIGoldConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIGotoRecharge = new TUIWindowRecharge(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         this.FOverlayerHelpTips.Visible = false;
         this.FOverlayerEquipment = new TOverlayerEquipment(this.Parent,FModuleID);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerRing = new TOverlayerRing(this.Parent,FModuleID);
         this.FOverlayerRing.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this.Parent,FModuleID);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Parent,FModuleID);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this.Parent,FModuleID);
         this.FOverlayerAccessory.Visible = false;
         this.FOverSuperJade = new TOverSuperJade(this.Parent);
         this.FOverSuperJade.Visible = false;
         this.FOverlayerMedal = new TOverlayerMedal(this.Parent,FModuleID);
         this.FOverlayerMedal.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerRing);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverSuperJade);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerMedal);
         this.FUIGoldConfirmation.OnOK = this.GoldConfirmationOnOK;
         this.FUIGoldConfirmation.OnCancel = this.GoldCofirmationOnCancel;
         this.FUIGoldConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIGoldConfirmation.WindowWidth) / 2;
         this.FUIGoldConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIGoldConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIGoldConfirmation);
         this.FUIGoldConfirmation.SetCheckBox(true);
         this.FUIGotoRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIGotoRecharge.WindowWidth) / 2;
         this.FUIGotoRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIGotoRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIGotoRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function SetUIModuleID(param1:uint) : void
      {
         FModuleID = param1;
      }
      
      protected function ProcessorClose() : void
      {
         if(this.FOnClose != null)
         {
            this.FOnClose(this);
         }
         Visible = false;
      }
      
      protected function PopTipsNotifyUpdate() : void
      {
         if(this.FOnUpdatePopTipsModes != null)
         {
            this.FOnUpdatePopTipsModes(this);
         }
      }
      
      protected function PopTipsNotifyCheck() : void
      {
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               if(_loc3_.CategorySecond == 7)
               {
                  _loc4_ = this.FOverlayerRing;
               }
               else
               {
                  _loc4_ = this.FOverlayerEquipment;
               }
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            case CATEGORY_Medal:
               _loc4_ = this.FOverlayerMedal;
               break;
            default:
               if(SLogicsCore.LostShenQiLogicData.GetBooJade(_loc3_.IDTemplate))
               {
                  _loc4_ = this.FOverSuperJade;
               }
               else
               {
                  _loc4_ = this.FOverlayerAppliance;
               }
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         if(param2 == null)
         {
            if(this.FOverlayerEquipment.visible)
            {
               this.FOverlayerEquipment.Hide();
            }
            if(this.FOverlayerRing.visible)
            {
               this.FOverlayerRing.Hide();
            }
            if(this.FOverlayerTreasure.visible)
            {
               this.FOverlayerTreasure.Hide();
            }
            if(this.FOverlayerAccessory.visible)
            {
               this.FOverlayerAccessory.Hide();
            }
            if(this.FOverlayerAppliance.visible)
            {
               this.FOverlayerAppliance.Hide();
            }
            if(this.FOverlayerMedal.visible)
            {
               this.FOverlayerMedal.Hide();
            }
            return;
         }
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               if(_loc3_.CategorySecond == 7)
               {
                  _loc4_ = this.FOverlayerRing;
               }
               else
               {
                  _loc4_ = this.FOverlayerEquipment;
               }
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            case CATEGORY_Medal:
               _loc4_ = this.FOverlayerMedal;
               break;
            default:
               if(SLogicsCore.LostShenQiLogicData.GetBooJade(_loc3_.IDTemplate))
               {
                  _loc4_ = this.FOverSuperJade;
               }
               else
               {
                  _loc4_ = this.FOverlayerAppliance;
               }
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function ProcessorOnBuyBoxClick(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0, param8:int = 0) : void
      {
         this.FBuyBoxObj.ActivityType = param1;
         this.FBuyBoxObj.BoxIndex = param3;
         this.FBuyBoxObj.Cost = param2;
         this.FBuyBoxObj.CostType = param4;
         this.FBuyBoxObj.BoxIndex1 = param6;
         this.FBuyBoxObj.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD && param4 != TBaseActivity.SWEET_TYPE_GOLD_GIFT)
         {
            this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            return;
         }
         if(!this.FUIGoldConfirmation.IsSelected || param8 != 0)
         {
            this.FCurCost = param2;
            if(param5 != "")
            {
               this.FUIGoldConfirmation.Text = param5;
            }
            else
            {
               this.FUIGoldConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCurCost);
            }
            this.FUIGoldConfirmation.SetCheckBox(true);
            this.FUIGoldConfirmation.Visible = true;
         }
         else
         {
            this.GoldConfirmationOnOK();
         }
      }
      
      protected function GoldConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(this.FBuyBoxObj.CostType == TBaseActivity.SWEET_TYPE_GOLD)
         {
            if(_loc2_.CreditGold >= this.FBuyBoxObj.Cost)
            {
               this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            }
            else
            {
               this.FUIGotoRecharge.Visible = true;
            }
         }
         else if(this.FBuyBoxObj.CostType == TBaseActivity.SWEET_TYPE_GOLD_GIFT)
         {
            if(_loc2_.CreditGold + _loc2_.CreditGiftCertificate >= this.FBuyBoxObj.Cost)
            {
               this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            }
            else
            {
               this.FUIGotoRecharge.Visible = true;
            }
         }
      }
      
      protected function ProcessorOnGetBoxClick(param1:int, param2:int = 0, param3:int = 0) : void
      {
      }
      
      protected function GoldCofirmationOnCancel(param1:Object = null) : void
      {
      }
      
      protected function ProcessorOnShowHtmlText(param1:String) : void
      {
         param1 = param1;
         param1 = param1.split("&zt;").join("<");
         param1 = param1.split("&yt;").join(">");
         param1 = param1.split("%n%").join("<BR>");
         if(param1 == "")
         {
            return;
         }
         this.FHtmlHint.Content = null;
         this.FHtmlHint.Content = param1;
         this.UIHelpTipsHintOnOver(this,this.FHtmlHint);
      }
      
      protected function ProcessorOnHideHtmlText(param1:MouseEvent = null) : void
      {
         this.UIHelpTipsHintOnOut(this);
      }
      
      public function get OnClose() : Function
      {
         return this.FOnClose;
      }
      
      public function set OnClose(param1:Function) : void
      {
         this.FOnClose = param1;
      }
      
      public function get OnUpdatePopTipsModes() : Function
      {
         return this.FOnUpdatePopTipsModes;
      }
      
      public function set OnUpdatePopTipsModes(param1:Function) : void
      {
         this.FOnUpdatePopTipsModes = param1;
      }
      
      public function get OnCheckPopTipsModes() : Function
      {
         return this.FOnCheckPopTipsModes;
      }
      
      public function set OnCheckPopTipsModes(param1:Function) : void
      {
         this.FOnCheckPopTipsModes = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIGoldConfirmation.Load();
            this.FUIGotoRecharge.Load();
            return;
         }
         this.PopTipsNotifyCheck();
      }
      
      override public function Unmount() : void
      {
         this.FUIGoldConfirmation.Visible = false;
         this.FUIGotoRecharge.Visible = false;
         super.Unmount();
      }
      
      public function ProcessorOnCheckIconStatus(param1:uint, param2:uint, param3:Boolean) : void
      {
         if(this.CheckIconEffect != null)
         {
            this.CheckIconEffect(param1,param2,param3);
         }
      }
   }
}

