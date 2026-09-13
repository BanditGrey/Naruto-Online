package Processors.Game.Lobby.Exercise.SuperEquip
{
   import Components.Slots.TUISlot;
   import Foundation.Network.TPacket;
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
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorSuperEquip extends TProcessorBaseActivity
   {
      
      public static const STATUS_COUNT:int = 9;
      
      public static const BOX1_COUNT:uint = 6;
      
      public static const BOX2_COUNT:uint = 6;
      
      public static const BOX3_COUNT:uint = 3;
      
      public static const OTHER_BOX_COUNT:uint = 6 + 3 + 1;
      
      public static const GODEQUIP_SUPEREQUIP:uint = 60106024;
      
      public static const TYPE_BUY_GOD_EQUIP:uint = 1;
      
      public static const TYPE_BUY_WEAPON:uint = 2;
      
      public static const TYPE_BUY_EQUIP:uint = 3;
      
      public static const TYPE_GET_BOX:uint = 4;
      
      protected var FStatusList:Vector.<int>;
      
      protected var FBeClicked:Boolean;
      
      protected var FGodEquipIds:Vector.<Object>;
      
      protected var FGodEquipPrice:Vector.<Object>;
      
      protected var FGodEquipBuyLimit:Vector.<int>;
      
      protected var FEquips:Array;
      
      protected var FWeapons:Array;
      
      protected var FBoxID:int;
      
      protected var FSlotVect1:Vector.<TUISlot>;
      
      protected var FSlotVect2:Vector.<TUISlot>;
      
      protected var FSlot3:TUISlot;
      
      protected var FIDTemplates1:Vector.<uint>;
      
      protected var FInventories1:TInventories;
      
      protected var FSuperEquipIds:Vector.<uint>;
      
      protected var FInventories2:TInventories;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TProcessorSuperEquip(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FStatusList = new Vector.<int>(STATUS_COUNT);
         this.FSuperEquipIds = new Vector.<uint>();
         this.FBuyBoxDate = new Object();
      }
      
      public static function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
         }
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUISlot = null;
         var _loc6_:TConfigValue = null;
         super.ResourcesPerform_UIDispatch();
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GODEQUIP_CREDITSUIT) as TConfigValue;
         this.FGodEquipIds = _loc6_.Value as Vector.<Object>;
         _loc1_ = 0;
         while(_loc1_ < this.FGodEquipIds.length)
         {
            if(this.FGodEquipIds[_loc1_]["pro"] == SLogicsCore.Character.GetMainHero().Profession)
            {
               this.FIDTemplates1 = Vector.<uint>(this.FGodEquipIds[_loc1_]["value"]);
               break;
            }
            _loc1_++;
         }
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GODEQUIP_PRICE) as TConfigValue;
         this.FGodEquipPrice = _loc6_.Value as Vector.<Object>;
         FMC_Scene["TF_Price"].text = this.FGodEquipPrice[1][1];
         this.FSlotVect1 = new Vector.<TUISlot>(BOX1_COUNT);
         this.FInventories1 = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories1,this.FIDTemplates1);
         _loc1_ = 0;
         while(_loc1_ < BOX1_COUNT)
         {
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = FMC_Scene["MC_Slot" + _loc1_];
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.Init();
            this.FSlotVect1[_loc1_] = _loc5_;
            this.FSlotVect1[_loc1_].Context = this.FInventories1.GetInventoryByIndex(_loc1_);
            _loc1_++;
         }
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,GODEQUIP_SUPEREQUIP) as TConfigValue;
         this.FEquips = _loc6_.Value.equip as Array;
         this.FWeapons = _loc6_.Value.weapon as Array;
         this.FBoxID = _loc6_.Value.magEqup as int;
         this.FSuperEquipIds.length = 0;
         _loc2_ = int(this.FEquips.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSuperEquipIds.push(this.FEquips[_loc1_].equipID);
            _loc1_++;
         }
         _loc2_ = int(this.FWeapons.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSuperEquipIds.push(this.FWeapons[_loc1_].equipID);
            _loc1_++;
         }
         this.FSuperEquipIds.push(this.FBoxID);
         this.FSlotVect2 = new Vector.<TUISlot>(OTHER_BOX_COUNT - 1);
         this.FInventories2 = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories2,this.FSuperEquipIds);
         _loc1_ = 0;
         while(_loc1_ < OTHER_BOX_COUNT - 1)
         {
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = FMC_Scene["MC_Box" + _loc1_];
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.Init();
            this.FSlotVect2[_loc1_] = _loc5_;
            this.FSlotVect2[_loc1_].Context = this.FInventories2.GetInventoryByIndex(_loc1_);
            _loc1_++;
         }
         this.FSlot3 = new TUISlot(this);
         this.FSlot3.Resource = FMC_Scene["MC_Slot6"];
         this.FSlot3.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FSlot3.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
         this.FSlot3.OnOverlay = UIComponentsHintOnOver;
         this.FSlot3.OnOut = UIComponentsHintOnOut;
         this.FSlot3.Init();
         this.FSlot3.Context = this.FInventories2.GetInventoryByIndex(OTHER_BOX_COUNT - 1);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyGodEquip);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
         _loc2_ = int(BOX2_COUNT);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            FMC_Scene["MC_Equip" + _loc1_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyEquip);
            _loc1_++;
         }
         _loc2_ = int(BOX3_COUNT);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            FMC_Scene["MC_Weapon" + _loc1_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyWeapon);
            _loc1_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         super.LogicsPerform();
         if(FInitialized && this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FSlotVect1.length)
            {
               _loc2_ = this.FSlotVect1[_loc1_];
               _loc2_.Update();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this.FSlotVect2.length)
            {
               _loc2_ = this.FSlotVect2[_loc1_];
               _loc2_.Update();
               _loc1_++;
            }
            this.FSlot3.Update();
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateEquip();
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX2_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Equip" + _loc1_];
            _loc3_.TF_Price.text = this.FEquips[_loc1_].prize.toString();
            _loc3_.TF_Name.text = STRING_COMMON.GetItemNameByType(1,this.FEquips[_loc1_].equipID);
            if(this.FStatusList[3 + _loc1_] == TBaseActivity.STATUS_GETED)
            {
               _loc3_.BTN_Buy.visible = false;
               _loc3_.MC_Got.visible = true;
            }
            else
            {
               _loc3_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
               _loc3_.MC_Got.visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOX3_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Weapon" + _loc1_];
            _loc3_.MC_Tag.gotoAndStop(_loc1_ + 1);
            _loc3_.TF_Price.text = this.FWeapons[_loc1_].prize.toString();
            _loc3_.TF_Name.text = STRING_COMMON.GetItemNameByType(1,this.FWeapons[_loc1_].equipID);
            if(this.FStatusList[1] == TBaseActivity.STATUS_GETED)
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
            }
            else
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
            }
            _loc1_++;
         }
         if(this.FStatusList[0] == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.BTN_Buy.visible = false;
            FMC_Scene.MC_Got2.visible = true;
         }
         else
         {
            FMC_Scene.BTN_Buy.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
            FMC_Scene.MC_Got2.visible = false;
         }
         if(this.FStatusList[2] == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.BTN_Get.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
            FMC_Scene.MC_Got.visible = false;
         }
         else if(this.FStatusList[2] == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.BTN_Get.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            FMC_Scene.MC_Got.visible = false;
         }
         else if(this.FStatusList[2] == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = true;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyGodEquip(param1:MouseEvent) : void
      {
         if(this.FStatusList[0] == TBaseActivity.STATUS_GETED)
         {
            return;
         }
         this.ProcessorOnBuyBoxUp(TYPE_BUY_GOD_EQUIP,1,this.FGodEquipPrice[1][1],0,TBaseActivity.SWEET_TYPE_GOLD);
      }
      
      protected function ProcessorOnBuyWeapon(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FStatusList[1] == TBaseActivity.STATUS_GETED)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(9));
         this.ProcessorOnBuyBoxUp(TYPE_BUY_WEAPON,_loc2_ + 1,this.FWeapons[_loc2_].prize,0,TBaseActivity.SWEET_TYPE_GOLD);
      }
      
      protected function ProcessorOnBuyEquip(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(8));
         if(this.FStatusList[_loc2_ + 3] == TBaseActivity.STATUS_GETED)
         {
            return;
         }
         this.ProcessorOnBuyBoxUp(TYPE_BUY_EQUIP,_loc2_ + 1,this.FEquips[_loc2_].prize,0,TBaseActivity.SWEET_TYPE_GOLD);
      }
      
      protected function ProcessorOnGetBox(param1:MouseEvent) : void
      {
         if(this.FStatusList[2] != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         this.ProcessorOnGetBoxUp(TYPE_GET_BOX,1);
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:String = "", param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param4;
         this.FBuyBoxDate.BoxIndex2 = param7;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param5;
         if(param5 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex2);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param3;
            if(param6 != "")
            {
               FUIWindowConfirmation.Text = param6;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex2);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc7_ = new Vector.<int>();
         _loc7_.push(param2);
         if(param3 != 0)
         {
            _loc7_.push(param3);
         }
         if(param4 != 0)
         {
            _loc7_.push(param4);
         }
         PerformPacket_CS_AllReq(param1,_loc7_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < STATUS_COUNT)
         {
            this.FStatusList[_loc5_] = _loc2_.readInt();
            _loc5_++;
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:uint = 0;
         var _loc16_:TBaseBox = null;
         var _loc17_:uint = 0;
         var _loc18_:TBins = null;
         var _loc19_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc18_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case TYPE_BUY_GOD_EQUIP:
               this.FStatusList[0] = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.CheckStatus();
               this.UpdateUI();
               break;
            case TYPE_BUY_WEAPON:
               this.FStatusList[1] = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.CheckStatus();
               this.UpdateUI();
               break;
            case TYPE_BUY_EQUIP:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FStatusList[3 + _loc5_ - 1] = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.CheckStatus();
               this.UpdateUI();
               break;
            case TYPE_GET_BOX:
               this.FStatusList[2] = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               this.UpdateUI();
         }
      }
      
      public function CheckStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FStatusList.length)
         {
            if(_loc1_ != 2)
            {
               if(this.FStatusList[_loc1_] != TBaseActivity.STATUS_GETED)
               {
                  return;
               }
            }
            _loc1_++;
         }
         if(this.FStatusList[2] != TBaseActivity.STATUS_GETED)
         {
            this.FStatusList[2] = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

