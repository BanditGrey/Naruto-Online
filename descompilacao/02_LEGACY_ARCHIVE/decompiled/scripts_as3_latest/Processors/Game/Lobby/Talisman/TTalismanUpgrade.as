package Processors.Game.Lobby.Talisman
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TBaseEquip;
   import Logics.DatebaseVO.VO.TLostsacredGenerate;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.DatebaseVO.VO.TTreasureUpgrade;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowMaterialCost;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TALISMAN;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class TTalismanUpgrade extends TProcessorLobbyWindow
   {
      
      protected static const PosX_FUIWindowCostGoldConfirmation:uint = 112;
      
      protected static const PosY_FUIWindowCostGoldConfirmation:uint = 100;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FScene:MovieClip;
      
      protected var FTF_CostNum:TextField;
      
      protected var FTF_OwnNum:TextField;
      
      protected var FTF_NeedCost:TextField;
      
      protected var FTF_TalismanUpgrading:TextField;
      
      protected var FBtn_Upgrade:MovieClip;
      
      protected var FBtn_GoldUpgrade:MovieClip;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FTF_OldProperty:TextField;
      
      protected var FTF_NewProperty:TextField;
      
      protected var FMC_UpgradeSlot:TUISlot;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_Arrow:MovieClip;
      
      protected var FTF_UpgradeNum:TextField;
      
      protected var FMC_List:MovieClip;
      
      protected var FBin:TBins;
      
      protected var FRoleIndex:uint;
      
      protected var FInitialized:Boolean;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FCharacter:TCharacter;
      
      protected var FUIWindowCostGold:TUIWindowMaterialCost;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FCostGold:int;
      
      protected var FMixedCostGold:int;
      
      protected var FMC_FloatEffect:MovieClip;
      
      protected var FRandomNum:uint;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FContext:Object;
      
      protected var FItemIndex:uint;
      
      protected var FAddvalue:uint;
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FTalismanNameList:Vector.<TextField>;
      
      protected var FUpgradePaperNum:uint;
      
      protected var FBmpIcon:MovieClip;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FUpgradeType:uint;
      
      protected var FHint:THint;
      
      protected var FMC_MaskSiMiDa:MovieClip;
      
      protected var FMC_GoToLostPanel:MovieClip;
      
      protected var FCostInventorieName:String;
      
      protected var FCostItemCount:uint;
      
      protected var FOwnItemNum:uint;
      
      protected var FUpgradeOnclick:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnTipsOver:Function;
      
      protected var FOnTipsOut:Function;
      
      protected var FGoToLostPanelFunction:Function;
      
      protected var WoQu:Boolean;
      
      public function TTalismanUpgrade(param1:TUIComponent)
      {
         super(param1);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FCharacter = SLogicsCore.Character;
         this.FTalismanNameList = new Vector.<TextField>(3);
         this.FBtnList = new Vector.<MovieClip>();
         this.FHint = new THint();
         this.FInitialized = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TALISMAN.RESOURCESID_Swf_Talisman);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var Index:int = 0;
         var Count:uint = 0;
         var MC_FloatEffect:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TALISMAN.RESOURCE_ClassName_MC_Upgrade) as MovieClip;
         addChild(this.FScene);
         this.x = CONST_TALISMAN.POSX_MC_SCENE;
         this.y = CONST_TALISMAN.POSY_MC_SCENE;
         this.visible = false;
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FBtn_Upgrade = this.FScene[CONST_TALISMAN.RESOURCE_Link_Btn_Upgrade];
         this.FBtn_Upgrade.isClick = false;
         TGameUtil.setButtonMode(this.FBtn_Upgrade,false);
         this.FBtnList.push(this.FBtn_Upgrade);
         this.FBtn_GoldUpgrade = this.FScene[CONST_TALISMAN.RESOURCE_Link_Btn_GoldUpgrade];
         this.FBtn_GoldUpgrade.isClick = false;
         TGameUtil.setButtonMode(this.FBtn_GoldUpgrade,false);
         this.FBtnList.push(this.FBtn_GoldUpgrade);
         this.FTF_OldProperty = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_OldProperty];
         this.FTF_OldProperty.mouseEnabled = false;
         this.FTF_NewProperty = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_NewProperty];
         this.FTF_NewProperty.mouseEnabled = false;
         this.FTF_CostNum = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_CostNum];
         this.FTF_CostNum.mouseEnabled = false;
         this.FTF_OwnNum = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_OwnNum];
         this.FTF_OwnNum.mouseEnabled = false;
         this.FTF_NeedCost = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_NeedCost];
         this.FTF_NeedCost.mouseEnabled = false;
         this.FTF_UpgradeNum = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_UpgradeNum];
         this.FTF_UpgradeNum.mouseEnabled = false;
         this.FMC_UpgradeSlot = new TUISlot(this);
         this.FMC_UpgradeSlot.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_UpgradeSlot] as Sprite;
         this.FMC_UpgradeSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_UpgradeSlot.OnQuerySequenceContext = this.SlotsOnBigQuerySequenceContext;
         this.FMC_UpgradeSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_UpgradeSlot.OnOut = this.SlotsOnOut;
         this.FMC_UpgradeSlot.Init();
         this.FBmpIcon = this.FMC_UpgradeSlot.Resource[CONST_TALISMAN.RESOURCE_Link_MC_Bmp_Icon];
         this.FMC_FloatEffect = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_FloatEffect];
         Count = this.FTalismanNameList.length;
         Index = 0;
         while(Index < Count)
         {
            this.FTalismanNameList[Index] = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_TalismanNames + Index];
            Index++;
         }
         this.FTF_TalismanUpgrading = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_TalismanUpgrading];
         this.FTF_TalismanUpgrading.mouseEnabled = false;
         this.FMC_Effect = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Effect];
         this.FMC_List = this.FScene[CONST_TALISMAN.RESOURCE_Link_Mc_List];
         this.FMC_MaskSiMiDa = this.FScene["MC_MaskSiMiDa"];
         this.FMC_GoToLostPanel = this.FMC_MaskSiMiDa["MC_GoToLostPanel"];
         TGameUtil.setButtonMode(this.FMC_GoToLostPanel,true);
         this.FMC_MaskSiMiDa.visible = false;
         this.FScrollBar = new TScrollBar(this.FMC_List,348,false,0);
         this.FUIWindowCostGold = new TUIWindowMaterialCost(this,CONST_MODULES.MODULE_Talisman);
         TUtilityUIWindow.SetupWindowMaterialCost(this.FUIWindowCostGold);
         this.FUIWindowCostGold.OnOK = this.CostConfirm;
         this.FUIWindowCostGold.OnCancel = function():void
         {
            FUIWindowCostGold.visible = false;
         };
         this.FUIWindowCostGold.OnOverlay = this.SlotsOnMove;
         this.FUIWindowCostGold.OnOut = this.SlotsOnOut;
         this.FUIWindowCostGold.x = PosX_FUIWindowCostGoldConfirmation;
         this.FUIWindowCostGold.y = PosY_FUIWindowCostGoldConfirmation;
         this.FUIWindowRecharge = new TUIWindowRecharge(this);
         this.FUIWindowRecharge.x = PosX_FUIWindowCostGoldConfirmation;
         this.FUIWindowRecharge.y = PosY_FUIWindowCostGoldConfirmation;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FInitialized = true;
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FSystemLanguageBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         super.LogicsPerform();
         if(this.FInitialized == true)
         {
            this.FMC_UpgradeSlot.Update();
            _loc2_ = this.FMC_SingleEquipList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FMC_SingleEquipList[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
            this.FMC_FloatEffect.play();
         }
      }
      
      protected function SetEuuipInfo() : void
      {
         var Count:uint = 0;
         var Index:int = 0;
         var SingleEquip:TSingleEquip = null;
         var Inventory:TInventory = null;
         var TalismanName:String = null;
         var TalismanLevel:uint = 0;
         var TalismanQuality:uint = 0;
         var HerosNum:uint = 0;
         var TempNum:uint = 0;
         var Inventories:TInventories = null;
         var SetInfo:Function = function():void
         {
            if(Inventory != null)
            {
               SingleEquip = FMC_SingleEquipList[Index];
               if(SingleEquip != null)
               {
                  TalismanName = Inventory.Name;
                  TalismanLevel = Inventory.UpgradingLevel;
                  TalismanQuality = Inventory.Quality;
                  SingleEquip.SetEquip(Inventory,TalismanName,STRING_TALISMAN.STRINGS_TalismanUpgrade + TalismanLevel,TalismanQuality);
                  if(Inventory.Identifier0 == FIdentifier0 && Inventory.Identifier1 == FIdentifier1)
                  {
                     SingleEquip.OnSelect();
                  }
               }
            }
         };
         HerosNum = uint(this.FCharacter.Heros.Count);
         TempNum = HerosNum - 1;
         Inventories = new TInventories();
         if(this.FRoleIndex > TempNum)
         {
            Count = uint(this.FCharacter.Treasures.Count);
            Index = 0;
            while(Index < Count)
            {
               Inventory = this.FCharacter.Treasures.GetInventoryByIndex(Index);
               SetInfo();
               Index++;
            }
         }
         else
         {
            Count = CONST_TALISMAN.CAPACITY_TalismanNum;
            Index = 0;
            while(Index < Count)
            {
               Inventory = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex).TalismansMounted.GetInventoryByIndex(Index);
               if(Inventory != null)
               {
                  Inventories.Add(Inventory);
               }
               Index++;
            }
            Count = uint(Inventories.Count);
            Index = 0;
            while(Index < Count)
            {
               Inventory = Inventories.GetInventoryByIndex(Index);
               SetInfo();
               Index++;
            }
         }
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TInventory = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         this.FScrollBar.Clear();
         _loc10_ = 0;
         _loc8_ = uint(this.FCharacter.Heros.Count);
         _loc9_ = _loc8_ - 1;
         _loc1_ = this.FMC_SingleEquipList.length;
         _loc2_ = int(_loc1_ - 1);
         while(_loc2_ > -1)
         {
            _loc3_ = this.FMC_SingleEquipList[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_--;
         }
         this.FMC_SingleEquipList.length = 0;
         if(this.FRoleIndex > _loc9_)
         {
            _loc1_ = uint(this.FCharacter.Treasures.Count);
         }
         else
         {
            _loc1_ = CONST_TALISMAN.CAPACITY_TalismanNum;
         }
         this.WoQu = false;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.FRoleIndex > _loc9_)
            {
               _loc4_ = this.FCharacter.Treasures.GetInventoryByIndex(_loc2_);
            }
            else
            {
               _loc4_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex).TalismansMounted.GetInventoryByIndex(_loc2_);
            }
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.Name;
               _loc6_ = _loc4_.UpgradingLevel;
               _loc7_ = _loc4_.Quality;
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               _loc3_.StubReferences.Reference(this);
               _loc3_.OnClick = this.SingleEquipOnClick;
               _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
               _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
               _loc3_.OnOut = this.SlotsOnOut;
               _loc3_.OnOver = this.SlotsOnMove;
               this.FMC_SingleEquipList.push(_loc3_);
               _loc3_.SetEquip(_loc4_,_loc5_,STRING_TALISMAN.STRINGS_TalismanUpgrade + _loc6_,_loc7_);
               this.FScrollBar.AddItem(_loc3_);
               _loc10_++;
               if(_loc4_.Identifier0 == this.FIdentifier0 && _loc4_.Identifier1 == this.FIdentifier1)
               {
                  this.WoQu = true;
                  _loc3_.OnSelect();
               }
            }
            _loc2_++;
         }
         if(_loc1_ < CONST_TALISMAN.CAPACITY_EQUIP || _loc1_ == 0)
         {
            _loc1_ = CONST_TALISMAN.CAPACITY_EQUIP;
            _loc2_ = 0;
            while(_loc2_ < _loc1_ - _loc10_)
            {
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               this.FScrollBar.AddItem(_loc3_);
               _loc2_++;
            }
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TInventory = null;
         this.FTF_OldProperty.text = "";
         this.FTF_NewProperty.text = "";
         this.FTF_CostNum.text = "";
         this.FTF_OwnNum.text = "";
         this.FTF_NeedCost.textColor = 15518068;
         this.FTF_TalismanUpgrading.text = "";
         _loc2_ = this.FTalismanNameList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTalismanNameList[_loc1_].text = "";
            _loc1_++;
         }
         _loc3_ = SLogicsCore.Character.Appliances;
         _loc2_ = uint(_loc3_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetInventoryByIndex(_loc1_);
            if(_loc4_.CategorySecond == CONST_INVENTORY.CATEGORYSECOND_TreasureUpgrade)
            {
               this.FUpgradePaperNum += _loc4_.Quantity;
            }
            _loc1_++;
         }
         this.FTF_UpgradeNum.text = "* " + this.FUpgradePaperNum.toString();
      }
      
      protected function UpdateBtn() : void
      {
         this.FBtn_Upgrade.isClick = false;
         this.FBtn_GoldUpgrade.isClick = false;
         TGameUtil.setButtonMode(this.FBtn_Upgrade,false);
         TGameUtil.setButtonMode(this.FBtn_GoldUpgrade,false);
         if(!this.WoQu)
         {
            this.FMC_UpgradeSlot.Context = null;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Upgrade.addEventListener(MouseEvent.CLICK,this.FBtn_UpgradeClickHandler,false,0,true);
         this.FBtn_Upgrade.addEventListener(MouseEvent.MOUSE_MOVE,this.FBtn_UpgradeOnMoveHandler,false,0,true);
         this.FBtn_Upgrade.addEventListener(MouseEvent.ROLL_OUT,this.FBtn_UpgradeOnOutHandler,false,0,true);
         this.FBtn_GoldUpgrade.addEventListener(MouseEvent.CLICK,this.FBtn_GoldUpgradeClickHandler,false,0,true);
         this.FBtn_GoldUpgrade.addEventListener(MouseEvent.MOUSE_MOVE,this.FBtn_GoldUpgradeOnMoveHandler,false,0,true);
         this.FBtn_GoldUpgrade.addEventListener(MouseEvent.ROLL_OUT,this.FBtn_GoldUpgradeOnOutHandler,false,0,true);
         this.FMC_GoToLostPanel.addEventListener(MouseEvent.CLICK,this.GoToLostPanelClick);
         super.ResourcesPerform_UILocations();
      }
      
      protected function FBtn_UpgradeClickHandler(param1:MouseEvent) : void
      {
         if(this.FMC_UpgradeSlot.Context == null || this.FBtn_Upgrade.isClick == false)
         {
            return;
         }
         this.FUpgradeType = 0;
         if(this.FMixedCostGold <= 0)
         {
            this.CostConfirm(null);
         }
         else
         {
            this.FUIWindowCostGold.Context = this.FMC_UpgradeSlot.Context;
            this.FCostInventorieName = this.FUIWindowCostGold.Context.Name;
            this.FUIWindowCostGold.Label = TUtilityString.Format(STRING_TALISMAN.STRING_CurHas,this.FCostInventorieName,this.FOwnItemNum);
            this.FUIWindowCostGold.Quantity = "" + Math.min(this.FCostItemCount,this.FOwnItemNum);
            this.FUIWindowCostGold.GoldQuantity = "*" + this.FMixedCostGold;
            this.FUIWindowCostGold.visible = true;
         }
      }
      
      protected function FBtn_UpgradeOnMoveHandler(param1:MouseEvent) : void
      {
         this.FHint.Caption = STRING_TALISMAN.STRING_Upgrade;
         if(this.FOnTipsOver != null)
         {
            this.FOnTipsOver(this,this.FHint);
         }
      }
      
      protected function FBtn_UpgradeOnOutHandler(param1:MouseEvent) : void
      {
         if(this.FOnTipsOut != null)
         {
            this.FOnTipsOut(this);
         }
      }
      
      protected function CostConfirm(param1:Object) : void
      {
         var _loc2_:TEquipment = null;
         _loc2_ = this.FContext as TEquipment;
         this.FIdentifier0 = _loc2_.Identifier0;
         this.FIdentifier1 = _loc2_.Identifier1;
         this.FUpgradeOnclick(this,this.FContext,this.FUpgradeType);
         this.SetBtnLock(false);
         this.FMC_Effect.play();
         this.FUIWindowCostGold.visible = false;
      }
      
      protected function FBtn_GoldUpgradeOnMoveHandler(param1:MouseEvent) : void
      {
         this.FHint.Caption = STRING_TALISMAN.STRING_GoldUpgrade;
         if(this.FOnTipsOver != null)
         {
            this.FOnTipsOver(this,this.FHint);
         }
      }
      
      protected function FBtn_GoldUpgradeOnOutHandler(param1:MouseEvent) : void
      {
         if(this.FOnTipsOut != null)
         {
            this.FOnTipsOut(this);
         }
      }
      
      protected function GoToLostPanelClick(param1:MouseEvent) : void
      {
         if(this.FGoToLostPanelFunction != null)
         {
            this.FGoToLostPanelFunction();
         }
      }
      
      protected function FBtn_GoldUpgradeClickHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:TInventories = null;
         if(this.FMC_UpgradeSlot.Context == null || this.FBtn_GoldUpgrade.isClick == false)
         {
            return;
         }
         if(this.FCostGold > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.visible = true;
            this.FUIWindowRecharge.MaskUi.height = CONST_COMMON.STAGE_Height * 2;
            this.FUIWindowRecharge.MaskUi.width = CONST_COMMON.STAGE_Width * 2;
            this.FUIWindowRecharge.MaskUi.x = -CONST_COMMON.STAGE_Width / 2;
            this.FUIWindowRecharge.MaskUi.y = -CONST_COMMON.STAGE_Height / 2;
            return;
         }
         this.FUpgradeType = 1;
         _loc3_ = new TInventories();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc3_,Vector.<uint>([CONST_TALISMAN.TALISMAN_UpgradePaper]));
         this.FUIWindowCostGold.Context = _loc3_.GetInventoryByIndex(0);
         this.FCostInventorieName = this.FUIWindowCostGold.Context.Name;
         this.FUIWindowCostGold.Label = TUtilityString.Format(STRING_TALISMAN.STRING_CurHas,this.FCostInventorieName,this.FUpgradePaperNum);
         this.FUIWindowCostGold.Quantity = "" + Math.min(this.FCostItemCount,this.FUpgradePaperNum);
         this.FUIWindowCostGold.GoldQuantity = "*" + this.FCostGold;
         this.FUIWindowCostGold.visible = true;
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TTreasureUpgrade = null;
         var _loc5_:TTreasureUpgrade = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TBaseEquip = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:int = 0;
         var _loc14_:uint = 0;
         var _loc15_:TSingleEquip = null;
         var _loc16_:TSingleEquip = null;
         var _loc17_:TInventory = null;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:TInventories = null;
         var _loc21_:TEquipment = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:Boolean = false;
         var _loc24_:TLostsacredGenerate = null;
         _loc22_ = new Vector.<uint>();
         _loc20_ = new TInventories();
         this.FContext = param2 as TInventory;
         _loc3_ = param2 as TInventory;
         _loc15_ = param1 as TSingleEquip;
         _loc23_ = false;
         _loc24_ = SLogicsCore.LostShenQiLogicData.LostsacredGenerateBins.GetDatebaseByValue("ArtifactId",_loc3_.IDTemplate) as TLostsacredGenerate;
         if(_loc24_)
         {
            this.FMC_MaskSiMiDa.visible = true;
            _loc15_.BSelect = false;
            return;
         }
         this.FMC_MaskSiMiDa.visible = false;
         _loc10_ = _loc3_.IDTemplate;
         _loc19_ = _loc3_.UpgradingLevel;
         _loc6_ = _loc19_ + 1;
         _loc14_ = uint(this.FBin.Count);
         _loc13_ = 0;
         while(_loc13_ < _loc14_)
         {
            _loc5_ = this.FBin.GetDatebaseByIndex(_loc13_) as TTreasureUpgrade;
            _loc11_ = _loc5_.Itemid;
            _loc12_ = _loc5_.Level;
            if(_loc11_ == _loc10_ && _loc12_ == _loc6_)
            {
               _loc23_ = true;
               break;
            }
            _loc13_++;
         }
         if(!_loc23_)
         {
            this.WoQu = false;
            this.UpdateBtn();
            _loc15_.BSelect = false;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_13) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            return;
         }
         _loc14_ = uint(this.FBin.Count);
         _loc13_ = 0;
         while(_loc13_ < _loc14_)
         {
            _loc5_ = this.FBin.GetDatebaseByIndex(_loc13_) as TTreasureUpgrade;
            _loc11_ = _loc5_.Itemid;
            _loc12_ = _loc5_.Level;
            if(_loc11_ == _loc10_)
            {
               if(_loc12_ == _loc6_)
               {
                  this.FCostItemCount = _loc5_.CostItemCount;
                  _loc7_ = _loc5_.AddValue;
                  _loc22_.push(_loc11_);
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc20_,_loc22_);
                  _loc21_ = _loc20_.GetInventoryByTempletID(_loc11_) as TEquipment;
                  _loc21_.UpgradingLevel = _loc12_;
                  _loc21_.UpgradingBasisProperty = _loc7_;
               }
               else if(_loc12_ == _loc19_)
               {
                  _loc18_ = _loc5_.AddValue;
               }
            }
            _loc13_++;
         }
         this.FMC_UpgradeSlot.Context = _loc3_;
         this.FBmpIcon.filters = [new GlowFilter(CONST_COMMON.QUALITYCOLOR_INDEX[_loc3_.Quality],0.9,17,15,3)];
         _loc9_ = (_loc3_ as TEquipment).BasisProperty;
         this.FOwnItemNum = 0;
         _loc14_ = uint(this.FCharacter.Treasures.Count);
         _loc13_ = 0;
         while(_loc13_ < _loc14_)
         {
            _loc17_ = this.FCharacter.Treasures.GetInventoryByIndex(_loc13_);
            if(_loc17_ != _loc3_ && _loc17_.IDTemplate == _loc3_.IDTemplate && _loc17_.UpgradingLevel == 0)
            {
               ++this.FOwnItemNum;
            }
            _loc13_++;
         }
         this.FMixedCostGold = _loc5_.CostGold * (this.FCostItemCount - (this.FOwnItemNum + this.FUpgradePaperNum));
         this.FCostGold = _loc5_.CostGold * (this.FCostItemCount - this.FUpgradePaperNum);
         if(this.FCostGold < 0)
         {
            this.FCostGold = 0;
         }
         if(this.FMixedCostGold < 0)
         {
            this.FMixedCostGold = 0;
         }
         _loc14_ = this.FMC_SingleEquipList.length;
         _loc13_ = 0;
         while(_loc13_ < _loc14_)
         {
            this.FMC_SingleEquipList[_loc13_].BClick = false;
            _loc13_++;
         }
         _loc15_.BSelect = true;
         this.FTF_OldProperty.text = STRING_TALISMAN.STRINGS_TalismanProperty[_loc3_.CategorySecond - 7] + (_loc9_ + _loc18_);
         this.FTF_NewProperty.text = STRING_TALISMAN.STRINGS_TalismanProperty[_loc3_.CategorySecond - 7] + (_loc9_ + _loc7_);
         if(this.FMixedCostGold <= this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            this.FTF_NeedCost.textColor = CONST_COMMON.TEXT_Green_Color;
            this.FTF_CostNum.textColor = CONST_COMMON.TEXT_Green_Color;
            this.FBtn_Upgrade.isClick = true;
            TGameUtil.setButtonMode(this.FBtn_Upgrade,true);
         }
         else
         {
            this.FTF_NeedCost.textColor = CONST_COMMON.TEXT_Red_Color;
            this.FTF_CostNum.textColor = CONST_COMMON.TEXT_Red_Color;
            this.FBtn_Upgrade.isClick = false;
            TGameUtil.setButtonMode(this.FBtn_Upgrade,false);
         }
         this.FBtn_GoldUpgrade.isClick = true;
         TGameUtil.setButtonMode(this.FBtn_GoldUpgrade,true);
         _loc14_ = this.FTalismanNameList.length;
         _loc13_ = 0;
         while(_loc13_ < _loc14_)
         {
            this.FTalismanNameList[_loc13_].text = _loc3_.Name;
            this.FTalismanNameList[_loc13_].textColor = QUALITYCOLOR_INDEX[_loc3_.Quality];
            _loc13_++;
         }
         this.FTF_CostNum.text = "* " + this.FCostItemCount;
         this.FTF_OwnNum.text = "* " + this.FOwnItemNum;
         this.FTF_NeedCost.text = STRING_TALISMAN.STRINGS_TalismanCost;
         this.FTF_TalismanUpgrading.text = "+" + _loc19_;
         this.FAddvalue = _loc7_;
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2,null);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2,null);
         }
      }
      
      protected function SlotsOnBigQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 1) : void
      {
         this.SlotsOnQuerySequenceContext(param1,param2,param3,param4);
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Talisman);
         }
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TEquipment = null;
         if(param2 is TEquipment)
         {
            _loc4_ = param2 as TEquipment;
            if(_loc4_.UpgradingLevel > 0)
            {
               param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
            }
         }
      }
      
      public function get Bin() : TBins
      {
         return this.FBin;
      }
      
      public function set Bin(param1:TBins) : void
      {
         this.FBin = param1;
      }
      
      public function get UpgradeOnclick() : Function
      {
         return this.FUpgradeOnclick;
      }
      
      public function set UpgradeOnclick(param1:Function) : void
      {
         this.FUpgradeOnclick = param1;
      }
      
      public function get OnInventoryOver() : Function
      {
         return this.FOnInventoryOver;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function get OnInventoryOut() : Function
      {
         return this.FOnInventoryOut;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function get OnTipsOver() : Function
      {
         return this.FOnTipsOver;
      }
      
      public function set OnTipsOver(param1:Function) : void
      {
         this.FOnTipsOver = param1;
      }
      
      public function get OnTipsOut() : Function
      {
         return this.FOnTipsOut;
      }
      
      public function set OnTipsOut(param1:Function) : void
      {
         this.FOnTipsOut = param1;
      }
      
      public function set GoToLostPanelFunction(param1:Function) : void
      {
         this.FGoToLostPanelFunction = param1;
      }
      
      public function Update(param1:uint, param2:uint = 0) : void
      {
         this.FRoleIndex = param1;
         this.FItemIndex = param2;
         this.FRandomNum = Math.floor(Math.random() * 3);
         this.Reset();
         this.UpdateBtn();
         this.UpdateText();
         this.UpdateEquip();
      }
      
      public function UpdateUpgradeEquip() : void
      {
         this.Reset();
         this.UpdateBtn();
         this.UpdateText();
         this.SetEuuipInfo();
      }
      
      public function Reset() : void
      {
         this.FCostGold = 0;
         this.FMixedCostGold = 0;
         this.FRandomNum = 0;
         this.FContext = null;
         this.FItemIndex = 0;
         this.FAddvalue = 0;
         if(this.WoQu)
         {
         }
         this.FUpgradePaperNum = 0;
         this.FSystemLanguage = null;
      }
      
      public function ResetCopy() : void
      {
         this.WoQu = false;
         this.FIdentifier0 = 0;
         this.FIdentifier1 = 0;
      }
      
      public function SetBtnLock(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.FBtnList.length)
         {
            TGameUtil.LockOrUnlockButton(this.FBtnList[_loc2_],param1);
            _loc2_++;
         }
      }
   }
}

