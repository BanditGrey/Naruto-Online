package Processors.Game.Lobby.WorldMap
{
   import Components.Slots.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Campaign.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Items.*;
   import Logics.Streamization.Inventories.*;
   import Logics.Vip.*;
   import Processors.Game.Lobby.Campaign.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.Group.TitieGroup;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.*;
   
   public class TCampChoose extends TProcessorLobbyWindow
   {
      
      protected static const SELECTSTATUS_NONE:int = -1;
      
      protected static const SELECTSTATUS_NORMAL:int = 0;
      
      protected static const SELECTSTATUS_HARD:int = 1;
      
      protected static const MAX_STAR_COUNT:int = 5;
      
      protected static const MAX_SLOT_LENGTH:int = 16;
      
      protected var FHelpTips:THint;
      
      protected var FScene:MovieClip;
      
      protected var FCampaignModel:TCampaign;
      
      protected var FCityid:int;
      
      protected var FCurMissionID:int;
      
      protected var FSelectStatus:int;
      
      protected var FMaxStatus:int;
      
      protected var FNormalCityID:int;
      
      protected var FHardCityID:int;
      
      protected var FBackgroundBitmap:Bitmap;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FSingleBins:TBins;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FHintBtnReset:THint;
      
      protected var FHintBtnResetVipOpen:THint;
      
      protected var FNeedCost:int;
      
      protected var FCharacter:TCharacter;
      
      protected var FVipData:TVip;
      
      protected var FSingleResetChargeBins:TBins;
      
      protected var FInitSlot:Boolean;
      
      protected var FNodalModel:TNodal;
      
      protected var FMaxResetCount:uint;
      
      protected var FIsInit:Boolean;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      private var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FSlotsOnMove:Function;
      
      protected var FSlotsOnOut:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      private var currenSpr:MovieClip;
      
      private var FtabList:TitieGroup;
      
      private var FtabListMask:Sprite;
      
      public var MakeCampData:Function;
      
      public function TCampChoose(param1:TUIComponent, param2:TNodal)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FNodalModel = param2;
         this.FIsInit = false;
         this.FSingleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Single);
         this.FSingleResetChargeBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SingleResetCharge);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.ConfirmOnOk;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CAMPAIGN.RESOURCESID_Campaign);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.LoadingPrimary)
         {
            return;
         }
         this.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.InitCampChoose();
         this.FIsInit = true;
         this.UpdataUI();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function InitCampChoose() : void
      {
         this.FInitSlot = false;
         this.FHintBtnReset = new THint();
         this.FHintBtnResetVipOpen = new THint();
         this.FNeedCost = 0;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FInventories = new TInventories();
         this.SelectStatus = SELECTSTATUS_NONE;
         this.FUISlots = new Vector.<TUISlot>();
         this.FIDTemplates = new Vector.<uint>();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_NodalFB) as MovieClip;
         addChild(this.FScene);
         this.FtabListMask = new Sprite();
         this.FtabListMask.graphics.beginFill(16711935,1);
         this.FtabListMask.graphics.drawRect(0,0,222,121);
         this.FtabListMask.graphics.endFill();
         this.FScene.mc_item.addChild(this.FtabListMask);
         this.FScene.MC_BattleUILeft.addEventListener(MouseEvent.CLICK,this.onClickDowmHandler);
         this.FScene.MC_BattleUIRight.addEventListener(MouseEvent.CLICK,this.onClickUpHandler);
         this.FScene.MC_BattleUILeft.buttonMode = true;
         this.FScene.MC_BattleUIRight.buttonMode = true;
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseView);
         this.FScene.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FScene.btn_help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         TGameUtil.setMovieClipButton(this.FScene.mc_nodalContrl.btn_reset,true);
         this.FScene.mc_nodalContrl.btn_reset.addEventListener(MouseEvent.CLICK,this.OnReset);
         TGameUtil.setMovieClipButton(this.FScene.mc_nodalContrl.btn_enter,true);
         this.FScene.mc_nodalContrl.btn_enter.addEventListener(MouseEvent.CLICK,this.OnEnterBattle);
         TGameUtil.setMovieClipButton(this.FScene.mc_nodalContrl.btn_auto,true);
         this.FScene.mc_nodalContrl.btn_auto.addEventListener(MouseEvent.CLICK,this.OnAutoBattle);
         this.FScene.mc_nodalContrl.btn_auto.addEventListener(MouseEvent.MOUSE_MOVE,this.OnAutoBtnMove);
         this.FScene.mc_nodalContrl.btn_auto.addEventListener(MouseEvent.ROLL_OUT,this.OnAutoBtnOut);
         this.FScene.mc_nodalContrl.mc_select_0.addEventListener(MouseEvent.CLICK,this.OnSelectNormal);
         this.FScene.mc_nodalContrl.mc_select_1.addEventListener(MouseEvent.CLICK,this.OnSelectHard);
         this.FBackgroundBitmap = new Bitmap();
         this.FScene.mc_bg.addChild(this.FBackgroundBitmap);
         this.FScene.mc_nodalContrl.btn_reset.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_ResetOnMove,false,0,true);
         this.FScene.mc_nodalContrl.btn_reset.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_ResetOnOut,false,0,true);
         this.FCharacter = SLogicsCore.Character;
         this.FVipData = this.FCharacter.VipData;
         this.initList();
      }
      
      private function onClickDowmHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = this.FtabList.y + 31;
         if((this.FtabList.y <= 0 || Math.abs(_loc2_) >= 31) && this.FtabList.y != 0)
         {
            this.FtabList.y = _loc2_;
         }
      }
      
      private function onClickUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = this.FtabList.y - 31;
         if(Math.abs(_loc2_) + 84 < this.FtabList.height)
         {
            this.FtabList.y = _loc2_;
         }
      }
      
      protected function initList() : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         var _loc7_:TSingle = null;
         if(this.FtabList != null)
         {
            this.FtabList.dispose();
            this.FtabList = null;
         }
         this.FtabList = new TitieGroup(-5,1,0);
         this.FtabList.mask = this.FtabListMask;
         this.FScene.mc_item.addChild(this.FtabList);
         var _loc1_:uint = uint(SLogicsCore.Character.GetMainLevel());
         var _loc2_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Single);
         var _loc3_:Array = [];
         if(this.currenSpr)
         {
            this.currenSpr.MC_Select.visible = false;
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc2_.Count)
         {
            _loc7_ = _loc2_.GetDatebaseByIndex(_loc8_) as TSingle;
            if(_loc1_ >= _loc7_.Level && _loc7_.Prev == 0)
            {
               _loc4_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_NodalFB_ITEM) as MovieClip;
               _loc5_ = TextField(_loc4_.TF_BattleName);
               _loc6_ = TextField(_loc4_.TF_Level);
               _loc5_.text = _loc7_.Name;
               _loc5_.width = _loc5_.textWidth + 5;
               _loc6_.autoSize = TextFieldAutoSize.RIGHT;
               _loc6_.text = STRING_WORLDMAP.STRINGS_LV + _loc7_.Level;
               _loc6_.width = _loc6_.textWidth + 5;
               if(this.FCityid == _loc7_.Campaign)
               {
                  this.currenSpr = _loc4_;
               }
               else
               {
                  _loc4_.MC_Select.visible = false;
               }
               _loc5_.mouseEnabled = false;
               _loc6_.mouseEnabled = false;
               _loc4_.Campaign = _loc7_.Campaign.toString();
               _loc4_.buttonMode = true;
               _loc4_.addEventListener(MouseEvent.CLICK,this.enterFd);
               _loc4_.addChild(_loc5_);
               this.FtabList.addChild(_loc4_);
            }
            else if(_loc7_.Prev == 0)
            {
               _loc3_.push(_loc7_);
            }
            _loc8_++;
         }
         var _loc9_:int = 0;
         while(_loc9_ < _loc3_.length)
         {
            _loc7_ = _loc3_[_loc9_] as TSingle;
            if(_loc7_.Prev == 0)
            {
               _loc4_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_NodalFB_ITEM) as MovieClip;
               _loc4_.MC_Select.visible = false;
               _loc5_ = TextField(_loc4_.TF_BattleName);
               _loc6_ = TextField(_loc4_.TF_Level);
               _loc5_.text = _loc7_.Name;
               _loc5_.width = _loc5_.textWidth + 5;
               _loc6_.autoSize = TextFieldAutoSize.RIGHT;
               _loc6_.text = STRING_WORLDMAP.STRINGS_LV + _loc7_.Level + STRING_WORLDMAP.STRINGS_UNLOOK;
               _loc6_.width = _loc6_.textWidth + 5;
               _loc5_.mouseEnabled = false;
               _loc6_.mouseEnabled = false;
               _loc4_.Campaign = _loc7_.Campaign.toString();
               _loc4_.buttonMode = true;
               _loc4_.addChild(_loc5_);
               _loc4_.filters = [TGameUtil.gBlackFilters];
               this.FtabList.addChild(_loc4_);
            }
            _loc9_++;
         }
      }
      
      protected function enterFd(param1:MouseEvent) : void
      {
         if(this.currenSpr)
         {
            this.currenSpr.MC_Select.visible = false;
         }
         this.currenSpr = param1.currentTarget as MovieClip;
         this.currenSpr.MC_Select.visible = true;
         var _loc2_:int = int(param1.currentTarget.Campaign);
         this.MakeCampData(_loc2_);
         this.SetCityID(_loc2_);
      }
      
      protected function InitSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_SLOT_LENGTH)
         {
            _loc2_ = this.GetSlot();
            _loc2_.Resource = this.FScene["MC_Slot_" + _loc1_];
            _loc2_.Init();
            this.FUISlots[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      protected function set SelectStatus(param1:int) : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FSelectStatus = param1;
         if(this.FSelectStatus == SELECTSTATUS_NONE)
         {
            this.FScene.mc_nodalContrl.mc_select_0.gotoAndStop("disabled");
            this.FScene.mc_nodalContrl.mc_select_1.gotoAndStop("disabled");
         }
         else if(this.FSelectStatus == SELECTSTATUS_NORMAL)
         {
            this.FScene.mc_nodalContrl.mc_select_0.gotoAndStop("select");
            this.FScene.mc_nodalContrl.mc_select_1.gotoAndStop("disabled");
         }
         else if(this.FSelectStatus == SELECTSTATUS_HARD)
         {
            this.FScene.mc_nodalContrl.mc_select_0.gotoAndStop("disabled");
            this.FScene.mc_nodalContrl.mc_select_1.gotoAndStop("select");
         }
         if(this.FMaxStatus < SELECTSTATUS_HARD)
         {
            this.FScene.mc_nodalContrl.mc_select_1.gotoAndStop("close");
         }
      }
      
      protected function get SelectStatus() : int
      {
         return this.FSelectStatus;
      }
      
      protected function GetSlot() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(this);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc1_.OnOverlay = this.FSlotsOnMove;
         _loc1_.OnOut = this.FSlotsOnOut;
         _loc1_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         return _loc1_;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_WorldMap);
         }
      }
      
      protected function SetSlot() : void
      {
         var _loc1_:TUISlot = null;
         var _loc2_:int = 0;
         var _loc3_:TItem = null;
         var _loc4_:Sprite = null;
         var _loc5_:String = null;
         var _loc6_:TSingleResetCharge = null;
         var _loc7_:TItems = null;
         if(this.FCampaignModel == null)
         {
            return;
         }
         if(!this.FInitSlot)
         {
            this.FInitSlot = true;
            this.InitSlot();
         }
         this.FIDTemplates.length = 0;
         if(this.FCurMissionID == this.FNormalCityID)
         {
            _loc7_ = this.FCampaignModel.NormalDropItems;
         }
         else
         {
            _loc7_ = this.FCampaignModel.HardDropItems;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc7_.Count)
         {
            _loc3_ = _loc7_.RewardByIndex(_loc2_);
            this.FIDTemplates[_loc2_] = _loc3_.ID;
            _loc2_++;
         }
         this.FInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
         _loc2_ = 0;
         while(_loc2_ < this.FInventories.Count)
         {
            this.FUISlots[_loc2_].Context = this.FInventories.GetInventoryByIndex(_loc2_);
            this.FScene["MC_Slot_" + _loc2_].visible = true;
            _loc2_++;
         }
         while(_loc2_ < MAX_SLOT_LENGTH)
         {
            this.FScene["MC_Slot_" + _loc2_].visible = false;
            _loc2_++;
         }
         if(this.FCampaignModel.ResetCount != 0)
         {
            _loc6_ = this.FSingleResetChargeBins.GetDatebaseByIdentifier(this.FCampaignModel.ResetCount) as TSingleResetCharge;
            this.FNeedCost = _loc6_.Value;
            _loc5_ = STRING_WORLDMAP.STRINGS_ResetTip;
            _loc5_ = _loc5_.split("%count%").join(this.FNeedCost);
         }
         else
         {
            this.FNeedCost = 0;
            _loc5_ = STRING_WORLDMAP.STRINGS_ResetFreeTip;
         }
         this.FHintBtnReset.Caption = _loc5_;
      }
      
      protected function ConfirmOnOk(param1:Object = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TPacket = null;
         if(!this.CheckGoldIsEnough())
         {
            return;
         }
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_ResetFB);
         _loc2_ = _loc3_.Data;
         _loc2_.writeInt(this.FCityid);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function CheckGoldIsEnough() : Boolean
      {
         if(this.FNeedCost > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.Visible = true;
            return false;
         }
         return true;
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:TCity = null;
         var _loc2_:TSingle = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc7_:MovieClip = null;
         if(!this.FIsInit || this.FNodalModel == null)
         {
            return;
         }
         if(this.FNodalModel.GetCampStarByID(this.FCampaignModel.NormalCampId) > 0)
         {
            this.FMaxStatus = SELECTSTATUS_HARD;
         }
         if(this.FCurMissionID == this.FNormalCityID)
         {
            this.SelectStatus = SELECTSTATUS_NORMAL;
            _loc5_ = uint(this.FNodalModel.GetCampStarByID(this.FCampaignModel.NormalCampId));
         }
         else if(this.FCurMissionID == this.FHardCityID)
         {
            this.SelectStatus = SELECTSTATUS_HARD;
            _loc5_ = uint(this.FNodalModel.GetCampStarByID(this.FCampaignModel.HardCampId));
         }
         else
         {
            this.SelectStatus = SELECTSTATUS_NONE;
            _loc5_ = 0;
         }
         _loc2_ = this.FSingleBins.GetDatebaseByIdentifier(this.FCurMissionID) as TSingle;
         this.FScene.tf_desc.text = _loc2_.Desc;
         this.FScene.mc_nodalContrl.tf_power.text = "" + _loc2_.RecommendForce;
         _loc3_ = _loc2_.Name;
         this.FScene.mc_nodalContrl.tf_enterTimes.text = this.FCampaignModel.EnterCount + "/" + (this.FVipData.DailySingleReset + 1);
         TGameUtil.setMovieClipButton(this.FScene.mc_nodalContrl.btn_enter,!(this.FCampaignModel.EnterCount > this.FVipData.DailySingleReset + 1 && this.FCampaignModel.IsPass()));
         _loc4_ = 0;
         while(_loc4_ < MAX_STAR_COUNT)
         {
            this.FScene.mc_nodalContrl["mc_star_" + _loc4_].visible = Boolean(_loc5_ > _loc4_);
            _loc4_++;
         }
         if(this.FCampaignModel.Diffculty < 0)
         {
            this.FScene.mc_nodalContrl.mc_info.visible = false;
            this.FScene.mc_nodalContrl.mc_select_0.visible = true;
            this.FScene.mc_nodalContrl.mc_select_1.visible = true;
            this.FScene.mc_nodalContrl.mc_bg.visible = true;
            this.FScene.mc_nodalContrl.btn_reset.visible = false;
            this.FScene.mc_nodalContrl.btn_enter.visible = true;
         }
         else if(this.FCampaignModel.IsPass())
         {
            this.FScene.mc_nodalContrl.mc_info.visible = true;
            this.FScene.mc_nodalContrl.mc_select_0.visible = false;
            this.FScene.mc_nodalContrl.mc_select_1.visible = false;
            this.FScene.mc_nodalContrl.mc_bg.visible = false;
            this.FScene.mc_nodalContrl.btn_reset.visible = Boolean(this.FCampaignModel.ResetCount < this.FVipData.DailySingleReset + 1);
            this.FScene.mc_nodalContrl.btn_enter.visible = false;
            this.FScene.mc_nodalContrl.mc_info.tf_hard.text = _loc2_.Hard;
            this.FScene.mc_nodalContrl.mc_info.tf_pos.text = this.FCampaignModel.GetMaxEnemyCount(this.FSelectStatus) + "/" + this.FCampaignModel.GetMaxEnemyCount(this.FSelectStatus);
         }
         else
         {
            this.FScene.mc_nodalContrl.mc_info.visible = true;
            this.FScene.mc_nodalContrl.mc_select_0.visible = false;
            this.FScene.mc_nodalContrl.mc_select_1.visible = false;
            this.FScene.mc_nodalContrl.mc_bg.visible = false;
            this.FScene.mc_nodalContrl.btn_reset.visible = Boolean(this.FCampaignModel.ResetCount < this.FVipData.DailySingleReset + 1);
            this.FScene.mc_nodalContrl.btn_enter.visible = true;
            this.FScene.mc_nodalContrl.mc_info.tf_hard.text = _loc2_.Hard;
            this.FScene.mc_nodalContrl.mc_info.tf_pos.text = this.FCampaignModel.GetCurEnemyCount(this.FSelectStatus) + "/" + this.FCampaignModel.GetMaxEnemyCount(this.FSelectStatus);
         }
         this.SetSlot();
         this.FScene.mc_nodalContrl.btn_auto.visible = Boolean(this.FNodalModel.GetCampStarByID(this.FCurMissionID) > 0);
         TGameUtil.setMovieClipButton(this.FScene.mc_nodalContrl.btn_auto,this.FVipData.VipLevel >= this.FVipData.VipOpenLevel_AutoSingle);
         if(!this.FScene.mc_nodalContrl.btn_reset.visible)
         {
            if(this.FVipData.VipLevel < this.FVipData.VipOpenLevel_DailySingleReset)
            {
               this.FScene.mc_nodalContrl.btn_reset.visible = true;
               TGameUtil.setButtonMode(this.FScene.mc_nodalContrl.btn_reset,false);
            }
            else
            {
               TGameUtil.setButtonMode(this.FScene.mc_nodalContrl.btn_reset,true);
            }
         }
         var _loc6_:Array = this.FtabList.childrenList.getItems;
         for each(_loc7_ in _loc6_)
         {
            if(this.FCityid == _loc7_.Campaign)
            {
               _loc7_.MC_Select.visible = true;
            }
            else
            {
               _loc7_.MC_Select.visible = false;
            }
         }
      }
      
      protected function OnCloseView(param1:MouseEvent) : void
      {
         Visible = false;
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Campaign) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function OnReset(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FCampaignModel.ResetCount == 0)
         {
            this.ConfirmOnOk();
         }
         else if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_WORLDMAP.STRING_SureReset,this.FNeedCost);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.ConfirmOnOk();
         }
      }
      
      protected function OnEnterBattle(param1:MouseEvent) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TPacket = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_Hurdle);
         _loc2_ = _loc3_.Data;
         _loc2_.writeInt(this.FCityid);
         _loc2_.writeInt(this.FCurMissionID);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         Visible = false;
         if(this.FCampaignModel.Diffculty < 0)
         {
            this.FCampaignModel.EnterCount += 1;
         }
         if(this.FCurMissionID == this.FHardCityID)
         {
            this.FCampaignModel.Diffculty = TCampaign.Type_Hard;
         }
         else if(this.FCurMissionID == this.FNormalCityID)
         {
            this.FCampaignModel.Diffculty = TCampaign.Type_Noraml;
         }
      }
      
      protected function OnAutoBattle(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_AutoBattleFB);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(this.FCityid);
         _loc3_.writeInt(this.FCurMissionID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnAutoBtnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget.buttonMode))
         {
            return;
         }
         _loc2_ = STRING_COMMON.COMMON_OPENVIPTIP;
         this.FHintBtnResetVipOpen.Caption = _loc2_.split("%count%").join(this.FVipData.VipOpenLevel_AutoSingle);
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintBtnResetVipOpen);
         }
      }
      
      protected function OnAutoBtnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function OnSelectNormal(param1:MouseEvent) : void
      {
         if(this.SelectStatus == SELECTSTATUS_NORMAL)
         {
            return;
         }
         this.SelectStatus = SELECTSTATUS_NORMAL;
         this.FCurMissionID = this.FNormalCityID;
         this.Updata();
      }
      
      protected function OnSelectHard(param1:MouseEvent) : void
      {
         if(this.FMaxStatus < SELECTSTATUS_HARD)
         {
            return;
         }
         if(this.SelectStatus == SELECTSTATUS_HARD)
         {
            return;
         }
         this.SelectStatus = SELECTSTATUS_HARD;
         this.FCurMissionID = this.FHardCityID;
         this.Updata();
      }
      
      protected function Btn_ResetOnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget.buttonMode))
         {
            if(this.FHintOnMove != null)
            {
               this.FHintOnMove(param1,this.FHintBtnReset);
            }
         }
         else
         {
            _loc2_ = STRING_COMMON.COMMON_OPENVIPTIP;
            this.FHintBtnResetVipOpen.Caption = _loc2_.split("%count%").join(this.FVipData.VipOpenLevel_DailySingleReset);
            if(this.FHintOnMove != null)
            {
               this.FHintOnMove(param1,this.FHintBtnResetVipOpen);
            }
         }
      }
      
      protected function Btn_ResetOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function get SlotsOnMove() : Function
      {
         return this.FSlotsOnMove;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      public function get SlotsOnOut() : Function
      {
         return this.FSlotsOnOut;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function SetCityID(param1:int) : void
      {
         if(!this.FIsInit)
         {
            Load();
         }
         this.FCityid = param1;
         this.FCampaignModel = this.FNodalModel.GetCampaignById(param1);
         this.FNormalCityID = this.FCampaignModel.NormalCampId;
         this.FHardCityID = this.FCampaignModel.HardCampId;
         if(this.FCampaignModel != null)
         {
            if(this.FCampaignModel.Diffculty == TCampaign.Type_Hard)
            {
               this.FMaxStatus = SELECTSTATUS_HARD;
               this.FCurMissionID = this.FHardCityID;
            }
            else if(this.FCampaignModel.Diffculty == TCampaign.Type_Noraml)
            {
               this.FMaxStatus = SELECTSTATUS_NORMAL;
               this.FCurMissionID = this.FNormalCityID;
            }
            else if(this.FNodalModel.GetCampStarByID(this.FCampaignModel.NormalCampId) > 0)
            {
               this.FMaxStatus = SELECTSTATUS_HARD;
               this.FCurMissionID = this.FHardCityID;
            }
            else
            {
               this.FMaxStatus = SELECTSTATUS_NORMAL;
               this.FCurMissionID = this.FNormalCityID;
            }
            this.UpdataUI();
            return;
         }
         this.FMaxStatus = SELECTSTATUS_NONE;
         this.SelectStatus = SELECTSTATUS_NONE;
         this.FCurMissionID = 0;
         this.FCampaignModel = null;
      }
      
      public function Updata() : void
      {
         this.UpdataUI();
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TSingle = null;
         if(this.FCampaignModel == null || this.FSingleBins == null || this.FUISlots == null)
         {
            return;
         }
         _loc2_ = this.FSingleBins.GetDatebaseByIdentifier(this.FCurMissionID) as TSingle;
         TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBackgroundBitmap,CONST_MODULES.MODULE_WorldMap,_loc2_.BigImage);
         _loc1_ = 0;
         while(_loc1_ < this.FUISlots.length)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

