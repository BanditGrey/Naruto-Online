package Processors.Game.Lobby.Tower
{
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEnchantBattle;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.Tower.TTower;
   import Logics.Tower.TTowerData;
   import Logics.Vip.TVip;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.Tower.Conponents.TUITowerLevel;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOWER;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TOWER;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   public class TProcessorWindowTowerLevel extends TProcessorWindowTemplate
   {
      
      protected const REWARD_Levels:Vector.<uint> = Vector.<uint>([1,10,20,30]);
      
      protected var FMC_AccumBar:Sprite;
      
      protected var FMC_Strategy:MovieClip;
      
      protected var FMC_Challenge:MovieClip;
      
      protected var FMC_AutoChallenge:MovieClip;
      
      protected var FTF_Award:TextField;
      
      protected var FTF_HPTimes:TextField;
      
      protected var FBTN_AddHPTimes:SimpleButton;
      
      protected var FTF_LevelName:TextField;
      
      protected var FMC_AutoTime:MovieClip;
      
      protected var FMC_Award:Sprite;
      
      protected var FAutoBattleSprite:Sprite;
      
      protected var FTF_DropExplanation:TextField;
      
      protected var FUILevels:Vector.<TUITowerLevel>;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FTowerData:TTowerData;
      
      protected var FTower:TTower;
      
      protected var FAwardNum:uint;
      
      protected var FItemNames:String;
      
      protected var FBins:TBins;
      
      protected var FUIBoxes:Vector.<MovieClip>;
      
      protected var FMC_Bar:Sprite;
      
      protected var FVip:TVip;
      
      protected var FVipLevel:uint;
      
      protected var FIndex:int;
      
      protected var FHint:THint;
      
      protected var FAddCountCost:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FIsWin:Boolean;
      
      protected var FCurrentTime:uint;
      
      protected var FAutoTime:uint;
      
      protected var FMC_Confirm:MovieClip;
      
      protected var FTF_AutoBattleAward:TextField;
      
      protected var FStartTowerID:uint;
      
      protected var FIsStartAutoTime:Boolean;
      
      protected var FBuyHPMaxTimes:uint;
      
      protected var FChallengeOnClick:Function;
      
      protected var FAutoChallengeOnClick:Function;
      
      protected var FBuyHPTimesOnClick:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      public function TProcessorWindowTowerLevel(param1:TUIComponent)
      {
         super(param1);
         this.FUILevels = new Vector.<TUITowerLevel>(CONST_TOWER.CAPACITY_LevelCount);
         this.FUIBoxes = new Vector.<MovieClip>(CONST_TOWER.CAPACITY_Box);
         this.FAwardNum = 0;
         this.FItemNames = "";
         this.FHint = new THint();
         this.FAutoBattleSprite = new Sprite();
         this.FCharacter = SLogicsCore.Character;
         this.FVip = this.FCharacter.VipData;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOWER.RESOURCESID_Swf_Tower);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUITowerLevel = null;
         var _loc4_:MovieClip = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOWER.RESOURCE_ClassName_MC_TowerLevel) as Sprite;
         UIDispatch();
         TGameUtil.AddWindowMask(this.FAutoBattleSprite);
         addChild(this.FAutoBattleSprite);
         this.FAutoBattleSprite.visible = false;
         this.FMC_AutoTime = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOWER.RESOURCE_ClassName_MC_AutoTime) as MovieClip;
         this.FMC_AutoTime.x = (STAGE_Width - this.FMC_AutoTime.width) / 2;
         this.FMC_AutoTime.y = (STAGE_Height - this.FMC_AutoTime.height) / 2;
         this.FAutoBattleSprite.addChild(this.FMC_AutoTime);
         this.FMC_Award = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOWER.RESOURCE_ClassName_MC_Award) as Sprite;
         this.FMC_Award.x = (STAGE_Width - this.FMC_Award.width) / 2;
         this.FMC_Award.y = (STAGE_Height - this.FMC_Award.height) / 2;
         this.FMC_Confirm = this.FMC_Award["MC_Confirm"];
         TGameUtil.setButtonMode(this.FMC_Confirm,true);
         this.FTF_AutoBattleAward = this.FMC_Award["TF_AutoBattleAward"];
         this.FAutoBattleSprite.addChild(this.FMC_Award);
         this.FMC_Strategy = FMainUI["MC_Strategy"];
         this.FMC_Strategy.visible = false;
         this.FMC_Challenge = FMainUI["MC_Challenge"];
         TGameUtil.setButtonMode(this.FMC_Challenge,true);
         this.FMC_AutoChallenge = FMainUI["MC_AutoChallenge"];
         TGameUtil.setButtonMode(this.FMC_AutoChallenge,true);
         this.FBTN_AddHPTimes = FMainUI["BTN_AddHPTimes"];
         this.FTF_HPTimes = FMainUI["TF_HPTimes"];
         this.FMC_AccumBar = FMainUI["MC_AccumBar"];
         this.FMC_Bar = this.FMC_AccumBar["MC_Bar"];
         this.FTF_Award = FMainUI["TF_Award"];
         this.FTF_Award.text = "";
         _loc2_ = CONST_TOWER.CAPACITY_LevelCount;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUITowerLevel(this);
            _loc3_.Resource = FMainUI[CONST_TOWER.RESOURCE_Link_MC_Level + _loc1_] as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.Init();
            this.FUILevels[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc2_ = this.FUIBoxes.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FMC_AccumBar["MC_Box_" + _loc1_];
            _loc4_["TF_Count"].text = TUtilityString.Format(STRING_TOWER.FORMAT_Level,this.REWARD_Levels[_loc1_]);
            this.FUIBoxes[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FTF_LevelName = FMainUI["TF_LevelName"];
         this.FTF_DropExplanation = FMainUI["TF_DropExplanation"];
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.Tower_Battle_Tips) as TSystemLanguage;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Tower_Life_Need_Gold) as TConfigValue;
         this.FAddCountCost = _loc5_.Value as uint;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Tower_Fight_Time) as TConfigValue;
         this.FAutoTime = _loc5_.Value as uint;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Tower_Life_Buy_Gold) as TConfigValue;
         this.FBuyHPMaxTimes = _loc5_.Value as uint;
         UILocations();
         FHelpTips.Content = _loc1_.Desc;
         this.FMC_Challenge.addEventListener(MouseEvent.CLICK,this.ButtonChallengeOnClick,false,0,true);
         this.FMC_AutoChallenge.addEventListener(MouseEvent.CLICK,this.ButtonAutoChallengeOnClick,false,0,true);
         this.FMC_AutoChallenge.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonAutoChallengeOnMove,false,0,true);
         this.FMC_AutoChallenge.addEventListener(MouseEvent.ROLL_OUT,this.ButtonAutoChallengeOnOut,false,0,true);
         this.FMC_Confirm.addEventListener(MouseEvent.CLICK,this.MCConfirmOnClick,false,0,true);
         this.FBTN_AddHPTimes.addEventListener(MouseEvent.CLICK,this.ButtonAddHPTimesOnClick,false,0,true);
         this.FBTN_AddHPTimes.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonAddHPTimesOnMove,false,0,true);
         this.FBTN_AddHPTimes.addEventListener(MouseEvent.ROLL_OUT,this.ButtonAddHPTimesOnOut,false,0,true);
         _loc4_ = this.FUIBoxes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this.FUIBoxes[_loc3_];
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCBoxOnOver,false,0,true);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.MCBoxOnOut,false,0,true);
            _loc3_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FVipLevel = SLogicsCore.Character.VipLevel;
         this.FBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnchantBattle) as TBins;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(!this.Visible)
         {
            return;
         }
         if(this.FIsStartAutoTime)
         {
            _loc1_ = this.FCurrentTime - STimingCore.GetServerTick();
            this.FMC_AutoTime["MC_Number_1"].gotoAndStop(_loc1_ % 10 + 1);
            this.FMC_AutoTime["MC_Number_0"].gotoAndStop(int(_loc1_ / 10) + 1);
            if(_loc1_ < 0)
            {
               this.FIsStartAutoTime = false;
               this.FMC_Award.visible = true;
               this.FMC_AutoTime.visible = false;
               this.UpdatePopupWindow();
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdatePopupWindow() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TEnchantBattle = null;
         _loc1_ = "";
         this.FAwardNum = 0;
         if(this.FStartTowerID == 0)
         {
            this.FStartTowerID = 10001001 + this.FIndex * 1000;
         }
         _loc3_ = this.FTower.TowerID - this.FStartTowerID + 1;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FBins.GetDatebaseByIdentifier(_loc2_ + this.FStartTowerID) as TEnchantBattle;
            this.CalculateItemNum(_loc4_);
            _loc2_++;
         }
         _loc1_ += TUtilityString.Format(STRING_TOWER.FORMAT_AutoBatlle,this.FTower.Stageid) + "\n";
         _loc1_ += TUtilityString.Format(STRING_TOWER.FORMAT_ItemB,this.FItemNames,this.FAwardNum);
         this.FTF_AutoBattleAward.text = _loc1_;
      }
      
      protected function UpdateUI() : void
      {
         if(this.FIsWin)
         {
            setTimeout(this.UpdateUILevels,700);
         }
         else
         {
            this.UpdateUILevels();
         }
         this.UpdateMCBoxes();
         this.UpdateProgressBar();
         this.UpdateAwardInfo();
         this.UpdateHPTimes();
         this.UpdateBTNChallenge();
      }
      
      protected function UpdateMCBoxes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = this.FUIBoxes.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIBoxes[_loc1_];
            _loc3_.filters = this.REWARD_Levels[_loc1_] <= this.FTower.Stageid ? [] : [TGameUtil.GaryColorFilters];
            _loc1_++;
         }
      }
      
      protected function UpdateProgressBar() : void
      {
         var _loc1_:uint = 0;
         if(this.FTower.TowerID == 0)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = this.FTower.Stageid;
         }
         this.FMC_Bar.width = uint(_loc1_ / 30 * 560);
      }
      
      protected function UpdateAwardInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TEnchantBattle = null;
         this.FAwardNum = 0;
         _loc2_ = uint(this.FBins.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = this.FBins.GetDatebaseByIndex(_loc1_) as TEnchantBattle;
            if(this.FTower.Tower == _loc6_.Tower && this.FTower.TowerID >= _loc6_.Identifier)
            {
               this.CalculateItemNum(_loc6_);
            }
            _loc1_++;
         }
         _loc3_ = "";
         if(this.FTower.TowerID != 0)
         {
            _loc3_ += TUtilityString.Format(STRING_TOWER.FORMAT_ItemA,this.FItemNames,this.FAwardNum);
            _loc4_ = this.FTower.Level;
         }
         else
         {
            _loc5_ = 10001001 + this.FIndex * 1000;
            _loc6_ = this.FBins.GetDatebaseByIdentifier(_loc5_) as TEnchantBattle;
            _loc4_ = _loc6_.Level;
         }
         this.FTF_Award.text = _loc3_;
         if(_loc4_ < CONST_COMMON.Ninja_One_Reincarnation_Footstone)
         {
            this.FTF_DropExplanation.text = TUtilityString.Format(STRING_TOWER.FORMAT_DropExplanation,_loc4_,_loc4_ + 9);
         }
         else
         {
            this.FTF_DropExplanation.text = TUtilityString.Format(STRING_TOWER.FORMAT_DropExplanationCopy,STRING_COMMON.GetLevelStrByLevelLineFeed(_loc4_));
         }
      }
      
      protected function CalculateItemNum(param1:TEnchantBattle, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TFixedAward = null;
         var _loc6_:String = null;
         _loc6_ = "";
         if(!param2)
         {
            _loc4_ = param1.Awards.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = param1.Awards[_loc3_];
               this.FAwardNum += _loc5_.Amount;
               _loc3_++;
            }
         }
         _loc4_ = param1.Awardexs.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.Awardexs[_loc3_];
            this.FAwardNum += _loc5_.Amount;
            _loc3_++;
         }
         if(_loc5_ != null)
         {
            _loc6_ = STRING_COMMON.GetItemNameByType(_loc5_.Type,_loc5_.Code);
         }
         this.FItemNames = _loc6_;
      }
      
      protected function UpdateUILevels() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUITowerLevel = null;
         var _loc4_:TEnchantBattle = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc5_ = this.FTower.TowerID;
         if(_loc5_ == 0)
         {
            _loc5_ = 10001001 + this.FIndex * 1000;
         }
         _loc8_ = 10001001 + this.FIndex * 1000;
         _loc7_ = uint(_loc5_ % 100 / 5);
         _loc2_ = this.FUILevels.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUILevels[_loc1_];
            if(_loc7_ == 6)
            {
               _loc6_ = _loc1_ + _loc8_ + (_loc7_ - 1) * 5;
            }
            else
            {
               _loc6_ = _loc1_ + _loc8_ + _loc7_ * 5;
            }
            _loc4_ = this.FBins.GetDatebaseByIdentifier(_loc6_) as TEnchantBattle;
            _loc3_.Context = _loc4_;
            _loc3_.Update(this.FTower,this.FIsWin);
            _loc1_++;
         }
      }
      
      protected function UpdateHPTimes() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TEnchantBattle = null;
         var _loc3_:String = null;
         _loc1_ = this.FTower.TowerID;
         if(_loc1_ == 0)
         {
            _loc1_ = 10001001 + this.FIndex * 1000;
            _loc2_ = this.FBins.GetDatebaseByIdentifier(_loc1_) as TEnchantBattle;
            _loc3_ = _loc2_.Name;
         }
         else
         {
            _loc3_ = this.FTower.Name;
         }
         this.FTF_LevelName.text = _loc3_;
         this.FTF_HPTimes.text = this.FTowerData.PlayerHP.toString();
      }
      
      protected function UpdateBTNChallenge() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = this.FVipLevel >= this.FVip.VipOpenLevel_TowerDiscover;
         TGameUtil.setButtonMode(this.FMC_AutoChallenge,_loc1_);
         _loc1_ = !Boolean(this.FTower.StageClear);
         TGameUtil.setButtonMode(this.FMC_Challenge,_loc1_);
         this.FMC_Challenge.mouseEnabled = _loc1_;
      }
      
      protected function ButtonChallengeOnClick(param1:MouseEvent) : void
      {
         if(this.FChallengeOnClick != null)
         {
            this.FChallengeOnClick(this);
         }
      }
      
      protected function MCConfirmOnClick(param1:MouseEvent) : void
      {
         this.FAutoBattleSprite.visible = false;
      }
      
      protected function ButtonAutoChallengeOnClick(param1:MouseEvent) : void
      {
         if(this.FVipLevel < this.FVip.VipOpenLevel_TowerDiscover)
         {
            return;
         }
         this.FStartTowerID = this.FTower.TowerID;
         if(this.FAutoChallengeOnClick != null)
         {
            this.FAutoChallengeOnClick(this);
         }
      }
      
      protected function ButtonAddHPTimesOnClick(param1:MouseEvent) : void
      {
         if(this.FVipLevel < this.FVip.VipOpenLevel_TowerLife)
         {
            EffectGenerateText(TUtilityString.Format(STRING_TOWER.FORMAT_VIPAndOpen,this.FVip.VipOpenLevel_TowerLife));
            return;
         }
         if(this.FAddCountCost > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         if(this.FUIWindowConfirmation.IsSelected)
         {
            if(this.FBuyHPTimesOnClick != null)
            {
               this.FBuyHPTimesOnClick(this);
            }
         }
         else
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Town_AddHP).DescribeString,this.FAddCountCost);
            this.FUIWindowConfirmation.Visible = true;
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         if(this.FBuyHPTimesOnClick != null)
         {
            this.FBuyHPTimesOnClick(this);
         }
      }
      
      protected function MCBoxOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TEnchantBattle = null;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:String = null;
         _loc6_ = param1.currentTarget as MovieClip;
         _loc5_ = parseInt(_loc6_.name.split("_")[2]);
         _loc7_ = "";
         this.FAwardNum = 0;
         _loc3_ = uint(this.FBins.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FBins.GetDatebaseByIndex(_loc2_) as TEnchantBattle;
            if(this.FIndex + 1 == _loc4_.Tower && _loc4_.Stageid == this.REWARD_Levels[_loc5_])
            {
               this.CalculateItemNum(_loc4_);
               break;
            }
            _loc2_++;
         }
         _loc7_ = TUtilityString.Format(STRING_TOWER.FORMAT_ItemB,this.FItemNames,this.FAwardNum) + "\n";
         this.FHint.Caption = _loc7_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function MCBoxOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function ButtonAddHPTimesOnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FVipLevel < this.FVip.VipOpenLevel_TowerLife)
         {
            _loc2_ = TUtilityString.Format(STRING_TOWER.FORMAT_VIPAndOpen,this.FVip.VipOpenLevel_TowerLife);
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_TOWER.FORMAT_BuyHPTimes,this.FBuyHPMaxTimes - this.FTowerData.BuyHPTimes);
         }
         this.FHint.Caption = _loc2_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function ButtonAddHPTimesOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function ButtonAutoChallengeOnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FVipLevel >= this.FVip.VipOpenLevel_TowerDiscover)
         {
            return;
         }
         _loc2_ = "";
         _loc2_ = TUtilityString.Format(STRING_TOWER.FORMAT_VIPAndOpen,this.FVip.VipOpenLevel_TowerDiscover);
         this.FHint.Caption = _loc2_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function ButtonAutoChallengeOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      public function get ChallengeOnClick() : Function
      {
         return this.FChallengeOnClick;
      }
      
      public function set ChallengeOnClick(param1:Function) : void
      {
         this.FChallengeOnClick = param1;
      }
      
      public function get AutoChallengeOnClick() : Function
      {
         return this.FAutoChallengeOnClick;
      }
      
      public function set AutoChallengeOnClick(param1:Function) : void
      {
         this.FAutoChallengeOnClick = param1;
      }
      
      public function get BuyHPTimesOnClick() : Function
      {
         return this.FBuyHPTimesOnClick;
      }
      
      public function set BuyHPTimesOnClick(param1:Function) : void
      {
         this.FBuyHPTimesOnClick = param1;
      }
      
      public function get UIHintOnOver() : Function
      {
         return this.FUIHintOnOver;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function get UIHintOnOut() : Function
      {
         return this.FUIHintOnOut;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      public function Update(param1:TTowerData, param2:int, param3:Boolean = false) : void
      {
         this.FTowerData = param1;
         this.FTower = this.FTowerData.OpenTowers.GetTowerByIndex(param2);
         this.FIndex = param2;
         this.FIsWin = param3;
         this.UpdateUI();
      }
      
      public function UpdateHP(param1:TTowerData) : void
      {
         this.FTF_HPTimes.text = param1.PlayerHP.toString();
      }
      
      public function PlayeEffectRoleDisappear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUITowerLevel = null;
         _loc2_ = this.FUILevels.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUILevels[_loc1_];
            if(_loc3_.UIHeroContext != null)
            {
               _loc3_.PlayEffect();
            }
            _loc1_++;
         }
      }
      
      public function PlayAutoTime() : void
      {
         this.FAutoBattleSprite.visible = true;
         this.FMC_AutoTime.visible = true;
         this.FMC_Award.visible = false;
         this.FIsStartAutoTime = true;
         this.FCurrentTime = STimingCore.GetServerTick() + this.FAutoTime;
      }
   }
}

