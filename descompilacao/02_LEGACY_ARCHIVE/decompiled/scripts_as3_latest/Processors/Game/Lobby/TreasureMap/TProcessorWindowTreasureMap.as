package Processors.Game.Lobby.TreasureMap
{
   import Components.ScrollBar.*;
   import Components.Slots.TUISlot;
   import Foundation.Common.*;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Network.*;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.TreasureMap.*;
   import Processors.Game.Common.Effects.Display.TEffectBaseFlicker;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.TreasureMap.TTreasureProofChangTips;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   
   public class TProcessorWindowTreasureMap extends TUIComponent
   {
      
      protected static const MAX_REPORT_Count:uint = 40;
      
      protected static const MAX_COUNT_Slot:uint = 8;
      
      protected static const MAX_PROOF_ITEM:uint = 6;
      
      public static var StrFilters:GlowFilter = new GlowFilter(1971469,1,3,3,10);
      
      protected static const CAPACITY_Credits:int = CONST_CHARACTER.CAPACITY_Credits - 3;
      
      protected static const CREDITINDEX_Gold:int = CONST_CHARACTER.CREDITINDEX_Gold;
      
      protected static const CREDITINDEX_SilverCoin:int = CONST_CHARACTER.CREDITINDEX_SilverCoin;
      
      protected static const CREDITINDEX_GiftCertificate:int = CONST_CHARACTER.CREDITINDEX_GiftCertificate;
      
      protected var FScene:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FHintFastTip:THint;
      
      protected var FTreasureMapData:TTreasureMapData;
      
      protected var FTreasureMapHero:TTreasureMapHero;
      
      protected var FCharacter:TCharacter;
      
      protected var FHintSilverCoin:THint;
      
      protected var FMaxEnterTimes:int;
      
      protected var FMaxRobberyTimes:int;
      
      protected var FGameWinLessTimes:int;
      
      protected var FFastCost:int;
      
      protected var FFastCostUnit:int;
      
      protected var FMcVecProof:Vector.<MovieClip>;
      
      protected var FNewProofChangeVce:Vector.<Object>;
      
      protected var FOldProofChangeVce:Vector.<Object>;
      
      protected var FDiggingRewardBins:TDiggingReward;
      
      protected var FProofItems:Vector.<uint>;
      
      protected var FProofCount:Vector.<uint>;
      
      protected var FProofitemSpr:Vector.<String>;
      
      protected var FProofItemsTipCoent:String;
      
      protected var FDiggingBins:TBins;
      
      protected var FStarMapBins:TBins;
      
      protected var FStarPointBins:TBins;
      
      protected var FReportScrollBar:TScrollBar;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationTreasure:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FFreeReportTextFieldVect:Vector.<TextField>;
      
      protected var FCredits:Vector.<Object>;
      
      protected var FEffectFlickerCredits:Vector.<TEffectBaseFlicker>;
      
      protected var FProofChangePicId:Vector.<uint>;
      
      protected var FProofTip:TTreasureProofChangTips;
      
      protected var FreeRobCount:int = 0;
      
      protected var FreeTreasureCount:int = 0;
      
      protected var FOnEnterCity:Function;
      
      protected var FOnOpenDigMap:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnEffectText:Function;
      
      protected var FOnApplianceOnOver:Function;
      
      protected var FOnApplianceOnOut:Function;
      
      protected var FTutorialNextStep:Function;
      
      public function TProcessorWindowTreasureMap(param1:TUIComponent, param2:MovieClip)
      {
         var _loc4_:TConfigValue = null;
         var _loc5_:TEffectBaseFlicker = null;
         var _loc3_:uint = 0;
         super(param1);
         this.FScene = param2;
         this.FCharacter = SLogicsCore.Character;
         this.FUISlots = new Vector.<TUISlot>(MAX_COUNT_Slot);
         this.FIDTemplates = new Vector.<uint>(MAX_COUNT_Slot);
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FNewProofChangeVce = new Vector.<Object>();
         this.FOldProofChangeVce = new Vector.<Object>();
         this.FMcVecProof = new Vector.<MovieClip>();
         this.FProofItems = new Vector.<uint>();
         this.FProofitemSpr = new Vector.<String>();
         this.FProofCount = new Vector.<uint>(MAX_PROOF_ITEM);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Mast_FreeQuency) as TConfigValue;
         this.FMaxEnterTimes = int(_loc4_.Value);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Mast_Plunder) as TConfigValue;
         this.FMaxRobberyTimes = int(_loc4_.Value);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_ColdTime) as TConfigValue;
         this.FGameWinLessTimes = int(_loc4_.Value);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_CD_Gold) as TConfigValue;
         this.FFastCost = int(_loc4_.Value.value);
         this.FFastCostUnit = int(_loc4_.Value.time);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Proof_NewToNew) as TConfigValue;
         this.FNewProofChangeVce = Vector.<Object>(_loc4_.Value);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Proof_OldToNew) as TConfigValue;
         this.FOldProofChangeVce = Vector.<Object>(_loc4_.Value);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Proof_Order) as TConfigValue;
         this.FProofItems = Vector.<uint>(_loc4_.Value);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Proof_String) as TConfigValue;
         this.FProofItemsTipCoent = String(_loc4_.Value);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_FreeQuency) as TConfigValue;
         this.FreeTreasureCount = int(_loc4_.Value);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Plunder) as TConfigValue;
         this.FreeRobCount = int(_loc4_.Value);
         this.FDiggingBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Digging);
         this.FStarMapBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_StarMap);
         this.FStarPointBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_StarPoint);
         this.FCredits = new Vector.<Object>(CAPACITY_Credits);
         this.FCredits[CREDITINDEX_SilverCoin] = new UInt64();
         this.FHintSilverCoin = new THint();
         this.FEffectFlickerCredits = new Vector.<TEffectBaseFlicker>(CAPACITY_Credits);
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_Credits)
         {
            _loc5_ = new TEffectBaseFlicker();
            this.FEffectFlickerCredits[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.InitWindowTreasureMap();
      }
      
      protected function InitWindowTreasureMap() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TUISlot = null;
         var _loc3_:String = null;
         TGameUtil.setButtonMode(this.FScene.btn_back,true);
         this.FScene.btn_back.addEventListener(MouseEvent.CLICK,this.OnClose);
         TGameUtil.setButtonMode(this.FScene.mc_treasureBaseData.btn_dig,true);
         this.FScene.mc_treasureBaseData.btn_dig.addEventListener(MouseEvent.CLICK,this.OnOpenDigMap);
         this.FScene.mc_treasureBaseData.btn_fast.addEventListener(MouseEvent.CLICK,this.OnFastDigMap);
         this.FScene.mc_treasureBaseData.btn_fast.addEventListener(MouseEvent.MOUSE_MOVE,this.OnFastBtnMove);
         this.FScene.mc_treasureBaseData.btn_fast.addEventListener(MouseEvent.ROLL_OUT,this.OnFastBtnOut);
         TGameUtil.setButtonMode(this.FScene.mc_treasureBaseData.btn_heroIcon,true);
         switch(this.FCharacter.MainHero.ModelID)
         {
            case 11100001:
            case 11100007:
            case 11100013:
               _loc1_ = 1;
               break;
            case 11100002:
            case 11100008:
            case 11100014:
               _loc1_ = 2;
               break;
            case 11100003:
            case 11100009:
            case 11100015:
               _loc1_ = 3;
               break;
            case 11100004:
            case 11100010:
            case 11100016:
               _loc1_ = 4;
               break;
            case 11100005:
            case 11100011:
            case 11100017:
               _loc1_ = 5;
               break;
            case 11100006:
            case 11100012:
            case 11100018:
               _loc1_ = 6;
         }
         this.FScene.mc_treasureBaseData.btn_heroIcon.mc_heroIcon.gotoAndStop(_loc1_);
         this.FScene.mc_treasureBaseData.mc_reward.visible = false;
         this.FScene.mc_treasureBaseData.btn_heroIcon.addEventListener(MouseEvent.CLICK,this.OnHeroIconClick);
         this.FHintFastTip = new THint();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmationTreasure = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmationTreasure.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationTreasure.WindowWidth) / 2;
         this.FUIWindowConfirmationTreasure.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationTreasure.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationTreasure);
         this.FUIWindowConfirmationTreasure.OnOK = this.OnClickTreasure;
         this.FUIWindowRecharge = new TUIWindowRecharge(this);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FReportScrollBar = new TScrollBar(this.FScene.mc_report.mc_scroll,137);
         this.FFreeReportTextFieldVect = new Vector.<TextField>();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT_Slot)
         {
            _loc2_ = this.GetSlot();
            _loc2_.Resource = this.FScene.mc_treasureBaseData.mc_reward["mc_slot_" + _loc1_];
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.Init();
            _loc2_.OnOverlay = this.ApplianceOnOver;
            _loc2_.OnOut = this.ApplianceOnOut;
            this.FUISlots[_loc1_] = _loc2_;
            _loc1_++;
         }
         if(this.FCharacter.CreditSilverCoin.ToNumber() > STRING_COMMON.SilverCoinUnit)
         {
            _loc3_ = Math.floor(this.FCharacter.CreditSilverCoin.ToNumber() * STRING_COMMON.SilverCoinCoefficient) + STRING_COMMON.STRING_Thousand;
         }
         else
         {
            _loc3_ = this.FCharacter.CreditSilverCoin.ToString();
         }
         this.FScene.tf_silverCoin.text = _loc3_;
         this.FScene.tf_gold.text = this.FCharacter.CreditGold.toString();
         this.FScene.tf_giftCertificate.text = this.FCharacter.CreditGiftCertificate.toString();
         this.FScene.tf_silverCoin.addEventListener(MouseEvent.MOUSE_MOVE,this.TF_SilverCoinOnMove,false,0,true);
         this.FScene.tf_silverCoin.addEventListener(MouseEvent.MOUSE_OUT,this.TF_SilverCoinOnOut,false,0,true);
         _loc1_ = 0;
         while(_loc1_ < MAX_PROOF_ITEM)
         {
            this.FMcVecProof[_loc1_] = this.FScene["MC_Proof"]["MC_KingSoul_" + _loc1_];
            MovieClip(this.FMcVecProof[_loc1_]["MC_KingSoul"]).gotoAndStop(MAX_PROOF_ITEM - _loc1_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FMcVecProof.length)
         {
            this.FMcVecProof[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.ProofOver);
            this.FMcVecProof[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.ProofOut);
            this.FMcVecProof[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProofMove);
            _loc1_++;
         }
         this.FProofTip = new TTreasureProofChangTips(this);
         this.FProofTip.visible = false;
         this.FProofTip.mouseEnabled = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FProofTip);
      }
      
      public function ProofOver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(Number(_loc2_.length - 1)));
         this.FProofTip.Context = this.FProofItems[_loc3_];
         this.FProofTip.Render(FUICore.MouseCoordinate);
         this.FProofTip.Show();
      }
      
      public function ProofOut(param1:MouseEvent) : void
      {
         this.FProofTip.Hide();
      }
      
      public function ProofMove(param1:MouseEvent) : void
      {
         this.FProofTip.Render(FUICore.MouseCoordinate);
      }
      
      protected function RefreshProofCount() : void
      {
         var _loc2_:TInventory = null;
         var _loc1_:TInventories = SLogicsCore.Character.Appliances;
         var _loc3_:int = 0;
         while(_loc3_ < MAX_PROOF_ITEM)
         {
            this.FProofCount[_loc3_] = _loc1_.GetAllCountByTempletID(this.FProofItems[_loc3_]);
            _loc3_++;
         }
      }
      
      public function OpenMe() : void
      {
         var _loc1_:int = 0;
         this.RefreshProofCount();
         while(_loc1_ < this.FMcVecProof.length)
         {
            TextField(this.FMcVecProof[_loc1_]["TF_KingSoul"]).text = String(this.FProofCount[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function GetSlot() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(this);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         return _loc1_;
      }
      
      protected function GetItemStr(param1:int, param2:int, param3:int) : String
      {
         return param3 + STRING_COMMON.GetItemNameByType(param1,param2);
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TDigging = null;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:TDiggingReward = null;
         var _loc8_:String = null;
         if(this.FCharacter.CreditSilverCoin.ToNumber() > STRING_COMMON.SilverCoinUnit)
         {
            _loc4_ = Math.floor(this.FCharacter.CreditSilverCoin.ToNumber() * STRING_COMMON.SilverCoinCoefficient) + STRING_COMMON.STRING_Thousand;
         }
         else
         {
            _loc4_ = this.FCharacter.CreditSilverCoin.ToString();
         }
         this.FScene.tf_silverCoin.text = _loc4_;
         this.FScene.tf_gold.text = this.FCharacter.CreditGold.toString();
         this.FScene.tf_giftCertificate.text = this.FCharacter.CreditGiftCertificate.toString();
         this.FScene.mc_treasureBaseData.tf_robberyTimes.text = this.FTreasureMapData.RobberyTimes + "/" + this.FMaxRobberyTimes;
         this.FScene.mc_treasureBaseData.tf_canEnterTimes.text = this.FTreasureMapData.CurEnterTimes + "/" + this.FMaxEnterTimes;
         if(this.FTreasureMapHero == null)
         {
            TGameUtil.setButtonMode(this.FScene.mc_treasureBaseData.btn_dig,this.FTreasureMapData.CurEnterTimes < this.FMaxEnterTimes);
         }
         else if(this.FTreasureMapHero.LastTime > 0)
         {
            _loc5_ = this.FCharacter.GetMainHero().Level;
            TGameUtil.setButtonMode(this.FScene.mc_treasureBaseData.btn_dig,false);
            _loc2_ = this.FDiggingBins.GetDatebaseByIdentifier(this.FTreasureMapHero.CurQuality) as TDigging;
            _loc6_ = String(_loc5_) + String(_loc2_.Identifier);
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TDiggingReward,uint(_loc6_)) as TDiggingReward;
            _loc8_ = "";
            _loc1_ = 0;
            while(_loc1_ < _loc7_.MastGetReward.length)
            {
               _loc8_ += STRING_COMMON.GetItemNameByType(_loc7_.MastGetReward[_loc1_].type,_loc7_.MastGetReward[_loc1_].code) + " *" + _loc7_.MastGetReward[_loc1_].amount + "\n";
               _loc1_++;
            }
            this.FScene.mc_treasureBaseData.mc_reward.tf_reward1.text = _loc8_;
            this.FIDTemplates.length = 0;
            _loc1_ = 0;
            while(_loc1_ < MAX_COUNT_Slot)
            {
               _loc3_ = this.FScene.mc_treasureBaseData.mc_reward["mc_slot_" + _loc1_];
               if(_loc1_ < _loc2_.Award2Vect.length)
               {
                  _loc3_.visible = true;
                  this.FIDTemplates.push(_loc2_.Award2Vect[_loc1_].code);
               }
               else
               {
                  _loc3_.visible = false;
               }
               _loc1_++;
            }
            this.FInventories.Clear();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
            _loc1_ = 0;
            while(_loc1_ < this.FInventories.Count)
            {
               this.FUISlots[_loc1_].Context = this.FInventories.GetInventoryByIndex(_loc1_);
               _loc1_++;
            }
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene.mc_treasureBaseData.btn_dig,this.FTreasureMapData.CurEnterTimes < this.FMaxEnterTimes);
         }
      }
      
      protected function MakeHtmlReward(param1:Vector.<Object>, param2:int) : String
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         _loc4_ = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ != 0)
            {
               _loc4_ += ",";
            }
            _loc5_ = param1[_loc3_].amount * param2 / 100;
            _loc4_ += _loc5_ + STRING_COMMON.GetItemNameByType(param1[_loc3_].type,param1[_loc3_].code);
            _loc3_++;
         }
         return _loc4_;
      }
      
      protected function MakeHtmlReport(param1:TTreasureMapReport) : String
      {
         var _loc2_:String = null;
         var _loc3_:TDigging = null;
         var _loc4_:String = null;
         var _loc5_:TStarMap = null;
         var _loc6_:TStarPoint = null;
         var _loc7_:uint = 0;
         _loc3_ = this.FDiggingBins.GetDatebaseByIdentifier(param1.MapQuality) as TDigging;
         _loc2_ = STRING_TREASUREMAP.STRING_ReportTemplate;
         _loc2_ = _loc2_.split("%who1%").join(param1.PlayerNick);
         _loc2_ = _loc2_.split("%who2%").join(param1.RobberyPlayerNick);
         _loc2_ = _loc2_.split("%where%").join(_loc3_.Name);
         _loc6_ = this.FStarPointBins.GetDatebaseByIdentifier(param1.PlayerGeneralStarId) as TStarPoint;
         if(_loc6_ == null)
         {
            _loc7_ = 2;
         }
         else
         {
            _loc5_ = this.FStarMapBins.GetDatebaseByIdentifier(17200000 + _loc6_.MapId) as TStarMap;
            _loc7_ = uint(_loc5_.Quality);
         }
         _loc4_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc7_].toString(16);
         _loc4_ = "#" + _loc4_;
         _loc2_ = _loc2_.split("%colorwho1%").join(_loc4_);
         _loc6_ = this.FStarPointBins.GetDatebaseByIdentifier(param1.RobberyGeneralStarId) as TStarPoint;
         if(_loc6_ == null)
         {
            _loc7_ = 2;
         }
         else
         {
            _loc5_ = this.FStarMapBins.GetDatebaseByIdentifier(17200000 + _loc6_.MapId) as TStarMap;
            _loc7_ = uint(_loc5_.Quality);
         }
         _loc4_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc7_].toString(16);
         _loc4_ = "#" + _loc4_;
         _loc2_ = _loc2_.split("%colorwho2%").join(_loc4_);
         _loc4_ = CONST_TREASUREMAP.MapQualityColor[_loc3_.Rate];
         return _loc2_.split("%colorwhere%").join(_loc4_);
      }
      
      protected function UpdataReport() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:TextField = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc5_ = uint(this.FReportScrollBar.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            this.FFreeReportTextFieldVect.push(this.FReportScrollBar.Items[_loc1_]);
            _loc1_++;
         }
         this.FReportScrollBar.Clear();
         _loc4_ = Math.max(this.FTreasureMapData.ReportList.Count - MAX_REPORT_Count,0);
         _loc5_ = Math.min(this.FTreasureMapData.ReportList.Count,MAX_REPORT_Count);
         _loc1_ = _loc4_;
         while(_loc1_ < _loc5_)
         {
            _loc2_ = this.MakeHtmlReport(this.FTreasureMapData.ReportList.GetReportByIndex(_loc1_));
            if(this.FFreeReportTextFieldVect.length > 0)
            {
               _loc3_ = this.FFreeReportTextFieldVect.pop();
            }
            else
            {
               _loc3_ = new TextField();
               _loc3_.textColor = 16773067;
               _loc3_.mouseEnabled = false;
               _loc3_.multiline = true;
               _loc3_.wordWrap = true;
               _loc3_.width = 237;
               _loc3_.filters = [StrFilters];
            }
            _loc3_.htmlText = _loc2_;
            _loc3_.height = _loc3_.textHeight + 5;
            this.FReportScrollBar.AddItem(_loc3_);
            _loc1_++;
         }
      }
      
      protected function GetSelfTreasureMapHero() : TTreasureMapHero
      {
         var _loc1_:TTreasureMapHero = null;
         return this.FTreasureMapData.FightHeroList.GetMapHeroById(this.FCharacter.Identifier0,this.FCharacter.Identifier1) as TTreasureMapHero;
      }
      
      protected function OnFastDigMapSure(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TreasureMap_FastReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_TreasureMap);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function ApplianceOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnApplianceOnOver != null)
         {
            this.FOnApplianceOnOver(param1,param2);
         }
      }
      
      protected function ApplianceOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnApplianceOnOut != null)
         {
            this.FOnApplianceOnOut(param1,param2);
         }
      }
      
      public function GetCreditByIndex(param1:int) : Object
      {
         return this.FCredits[param1];
      }
      
      public function SetCreditByIndex(param1:int, param2:Object) : void
      {
         this.FCredits[param1] = param2;
      }
      
      public function get CreditSilverCoin() : UInt64
      {
         return this.FCredits[CREDITINDEX_SilverCoin] as UInt64;
      }
      
      protected function GetTFCreditByIndex(param1:uint) : TextField
      {
         switch(param1)
         {
            case CREDITINDEX_Gold:
               return this.FScene.tf_gold;
            case CREDITINDEX_SilverCoin:
               return this.FScene.tf_silverCoin;
            case CREDITINDEX_GiftCertificate:
               return this.FScene.tf_giftCertificate;
            default:
               return null;
         }
      }
      
      protected function LogicsPerform_CreditsEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:UInt64 = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TEffectBaseFlicker = null;
         var _loc8_:uint = 0;
         _loc2_ = CAPACITY_Credits;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = this.FEffectFlickerCredits[_loc1_];
            if(_loc1_ == CREDITINDEX_SilverCoin)
            {
               _loc3_ = new UInt64();
               _loc3_.High = this.FCharacter.CreditSilverCoin.High;
               _loc3_.Low = this.FCharacter.CreditSilverCoin.Low;
               if(_loc3_.ToNumber() > STRING_COMMON.SilverCoinUnit)
               {
                  _loc4_ = Math.floor(_loc3_.ToNumber() * STRING_COMMON.SilverCoinCoefficient) + STRING_COMMON.STRING_Thousand;
               }
               else
               {
                  _loc4_ = _loc3_.ToString();
               }
               this.FScene.tf_silverCoin.text = _loc4_;
               if(_loc3_.ToNumber() != this.CreditSilverCoin.ToNumber() && _loc7_.IsRunOver)
               {
                  (this.GetCreditByIndex(_loc1_) as UInt64).High = _loc3_.High;
                  (this.GetCreditByIndex(_loc1_) as UInt64).Low = _loc3_.Low;
                  _loc7_.SetParameters(this.GetTFCreditByIndex(_loc1_),4294936064);
               }
            }
            else
            {
               this.GetTFCreditByIndex(_loc1_).text = (this.FCharacter.GetCreditByIndex(_loc1_) as uint).toString();
               _loc5_ = uint(this.FCharacter.GetCreditByIndex(_loc1_));
               if(_loc5_ != uint(this.GetCreditByIndex(_loc1_)) && _loc7_.IsRunOver)
               {
                  this.SetCreditByIndex(_loc1_,_loc5_);
                  _loc7_.SetParameters(this.GetTFCreditByIndex(_loc1_));
               }
            }
            _loc1_++;
         }
         this.UpdateEffectsGlow();
      }
      
      protected function UpdateEffectsGlow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEffectBaseFlicker = null;
         _loc2_ = int(this.FEffectFlickerCredits.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEffectFlickerCredits[_loc1_];
            if(!_loc3_.IsRunOver)
            {
               _loc3_.Run();
            }
            _loc1_++;
         }
      }
      
      protected function OnClose(param1:MouseEvent) : void
      {
         if(this.FOnEnterCity != null)
         {
            this.FOnEnterCity(this);
         }
      }
      
      protected function OnOpenDigMap(param1:MouseEvent) : void
      {
         if(this.FTutorialNextStep != null)
         {
            this.FTutorialNextStep(1901);
         }
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FTreasureMapData.CurEnterTimes >= this.FMaxEnterTimes && this.FTreasureMapHero == null)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(STRING_TREASUREMAP.STRING_NOTENOUGH_Times);
            }
            return;
         }
         if(this.FTreasureMapData.CurEnterTimes >= this.FreeTreasureCount)
         {
            this.FUIWindowConfirmationTreasure.Text = STRING_TREASUREMAP.STRING_IsCostTreasureCard;
            this.FUIWindowConfirmationTreasure.visible = true;
         }
         else if(this.FOnOpenDigMap != null)
         {
            this.FOnOpenDigMap(this);
         }
      }
      
      protected function OnClickTreasure(param1:Object) : void
      {
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         var _loc3_:TInventory = _loc2_.GetInventoryByTempletID(14107064);
         if(!_loc3_)
         {
            this.FOnEffectText("寻宝卡不足，可到商城购买");
            return;
         }
         if(this.FOnOpenDigMap != null)
         {
            this.FOnOpenDigMap(this);
         }
      }
      
      protected function OnFastDigMap(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TDigging = null;
         var _loc6_:String = null;
         if(this.FTreasureMapHero == null)
         {
            return;
         }
         _loc5_ = this.FDiggingBins.GetDatebaseByIdentifier(this.FTreasureMapHero.CurQuality) as TDigging;
         _loc4_ = _loc5_.Digtime - (this.FTreasureMapHero.IsGameWin ? this.FGameWinLessTimes : 0);
         _loc3_ = _loc4_ + (this.FTreasureMapHero.LastTime - STimingCore.GetServerTick());
         _loc2_ = this.FFastCost * (int((_loc3_ - 1) / 60) + 1) / this.FFastCostUnit;
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < _loc2_)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         _loc6_ = STRING_TREASUREMAP.STRING_FastCostSure;
         _loc6_ = _loc6_.split("%count%").join(_loc2_);
         this.FUIWindowConfirmation.Text = _loc6_;
         this.FUIWindowConfirmation.OnOK = this.OnFastDigMapSure;
         this.FUIWindowConfirmation.visible = true;
      }
      
      protected function OnFastBtnMove(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TDigging = null;
         var _loc6_:TTreasureMapHero = null;
         if(this.FHintOnOver != null)
         {
            if(this.FTreasureMapHero == null)
            {
               return;
            }
            _loc5_ = this.FDiggingBins.GetDatebaseByIdentifier(this.FTreasureMapHero.CurQuality) as TDigging;
            _loc4_ = _loc5_.Digtime - (this.FTreasureMapHero.IsGameWin ? this.FGameWinLessTimes : 0);
            _loc3_ = _loc4_ + (this.FTreasureMapHero.LastTime - STimingCore.GetServerTick());
            _loc2_ = this.FFastCost * (int((_loc3_ - 1) / 60) + 1) / this.FFastCostUnit;
            this.FHintFastTip.Caption = STRING_TREASUREMAP.STRING_FastTip.split("%count%").join(_loc2_);
            this.FHintOnOver(this,this.FHintFastTip);
         }
      }
      
      protected function OnFastBtnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function TF_SilverCoinOnMove(param1:MouseEvent) : void
      {
         this.FHintSilverCoin.Caption = this.FCharacter.CreditSilverCoin.ToString();
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(param1,this.FHintSilverCoin);
         }
      }
      
      protected function TF_SilverCoinOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function OnHeroIconClick(param1:MouseEvent) : void
      {
         if(this.FTreasureMapHero == null)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(STRING_TREASUREMAP.STRING_To_Dig);
            }
            return;
         }
      }
      
      public function set OnEnterCity(param1:Function) : void
      {
         this.FOnEnterCity = param1;
      }
      
      public function get OnEnterCity() : Function
      {
         return this.FOnEnterCity;
      }
      
      public function set OpenDigMap(param1:Function) : void
      {
         this.FOnOpenDigMap = param1;
      }
      
      public function get OpenDigMap() : Function
      {
         return this.FOnOpenDigMap;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function get OnApplianceOnOver() : Function
      {
         return this.FOnApplianceOnOver;
      }
      
      public function set OnApplianceOnOver(param1:Function) : void
      {
         this.FOnApplianceOnOver = param1;
      }
      
      public function get OnApplianceOnOut() : Function
      {
         return this.FOnApplianceOnOut;
      }
      
      public function set OnApplianceOnOut(param1:Function) : void
      {
         this.FOnApplianceOnOut = param1;
      }
      
      public function set TutorialNextStep(param1:Function) : void
      {
         this.FTutorialNextStep = param1;
      }
      
      public function get NewProofChangeVce() : Vector.<Object>
      {
         return this.FNewProofChangeVce;
      }
      
      public function get OldProofChangeVce() : Vector.<Object>
      {
         return this.FOldProofChangeVce;
      }
      
      public function get ProofItems() : Vector.<uint>
      {
         return this.FProofItems;
      }
      
      public function UpdataEffect() : void
      {
         this.LogicsPerform_CreditsEffect();
      }
      
      public function UpdataColdDown() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TDigging = null;
         if(this.FTreasureMapHero)
         {
            _loc4_ = this.FDiggingBins.GetDatebaseByIdentifier(this.FTreasureMapHero.CurQuality) as TDigging;
            _loc3_ = _loc4_.Digtime - (this.FTreasureMapHero.IsGameWin ? this.FGameWinLessTimes : 0);
            _loc2_ = _loc3_ + (this.FTreasureMapHero.LastTime - STimingCore.GetServerTick());
            this.FScene.mc_treasureBaseData.tf_diggingTimes.text = TGameUtil.fomatTime(_loc2_);
            this.FScene.mc_treasureBaseData.btn_fast.visible = Boolean(_loc2_ > 0);
         }
         else
         {
            this.FScene.mc_treasureBaseData.tf_diggingTimes.text = TGameUtil.fomatTime(0);
            this.FScene.mc_treasureBaseData.btn_fast.visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FUISlots.length)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function SetTreasureMapData(param1:TTreasureMapData) : void
      {
         this.FTreasureMapData = param1;
         this.FTreasureMapHero = this.GetSelfTreasureMapHero();
         if(Boolean(this.FTreasureMapHero) && this.FTreasureMapData.TreasureStatus == false)
         {
            this.FTreasureMapHero.LastTime = 0;
         }
         this.UpdataUI();
         this.UpdataReport();
      }
      
      public function AddReport(param1:TTreasureMapData) : void
      {
         this.FTreasureMapData = param1;
         this.UpdataReport();
      }
      
      public function CheckCanDigging() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:TDigging = null;
         this.FTreasureMapHero = this.GetSelfTreasureMapHero();
         if(this.FTreasureMapHero)
         {
            _loc2_ = this.FDiggingBins.GetDatebaseByIdentifier(this.FTreasureMapHero.CurQuality) as TDigging;
            _loc1_ = _loc2_.Digtime - (this.FTreasureMapHero.IsGameWin ? this.FGameWinLessTimes : 0);
            if(this.FOnEffectText != null && _loc1_ + (this.FTreasureMapHero.LastTime - STimingCore.GetServerTick()) > 0)
            {
               this.FOnEffectText(STRING_TREASUREMAP.STRING_DiggingTip);
            }
            return false;
         }
         if(this.FMaxEnterTimes - this.FTreasureMapData.CurEnterTimes <= 0)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(STRING_TREASUREMAP.STRING_DiggingTimesEnd);
            }
            return false;
         }
         return true;
      }
   }
}

