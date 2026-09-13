package Processors.Game.Lobby.Organization.FightPetCopy
{
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.FightPet.TFightPet;
   import Logics.SLogicsCore;
   import Logics.TimeCoolDown.TTimeCoolDown;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_FIGHTPET;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_ANIMALSEAL;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TLayerOverCopy extends TProcessorLobbyWindow
   {
      
      protected static const RankNum:uint = 10;
      
      protected static const TYPE_MORALE:uint = 0;
      
      protected static const TYPE_RESURRECTION:uint = 1;
      
      protected var FTF_Sliver:TextField;
      
      protected var FTF_Gold:TextField;
      
      protected var FTF_Coupons:TextField;
      
      protected var FTF_MyDamage:TextField;
      
      protected var FTF_AllPlayer:TextField;
      
      protected var FTF_MonsterName:TextField;
      
      protected var FTF_HP:TextField;
      
      protected var FTF_CDNumber:TextField;
      
      protected var FMC_Morale:Sprite;
      
      protected var FMC_Description:Sprite;
      
      protected var FMC_Bar:Sprite;
      
      protected var FMC_FightCD:Sprite;
      
      protected var FMC_EnterTownCD:Sprite;
      
      protected var FMC_ResurrectionCD:Sprite;
      
      protected var FMC_Light:Sprite;
      
      protected var FMC_McAutoFire:MovieClip;
      
      protected var FMC_EndReward:TProcessorEndReward;
      
      protected var FBT_MoraleUp:MovieClip;
      
      protected var FMC_ColourBar:MovieClip;
      
      protected var FMC_ColourBarGround:MovieClip;
      
      protected var FMC_BossHead:MovieClip;
      
      protected var FBT_Resurrection:SimpleButton;
      
      protected var FRankList:Vector.<Sprite>;
      
      protected var FCDNumbers:Vector.<MovieClip>;
      
      protected var FEnterTownCDNumbers:Vector.<MovieClip>;
      
      protected var FCharacter:TCharacter;
      
      protected var FTotalHP:uint;
      
      protected var FConfigValue:TBins;
      
      protected var FType:uint;
      
      protected var FCost:uint;
      
      protected var FTime:uint;
      
      protected var FEasterTime:uint;
      
      protected var FModalLayer:Sprite;
      
      protected var FTimeCoolDown:TTimeCoolDown;
      
      protected var FFightPetCoolDown:TTimeCoolDown;
      
      protected var FIsDie:Boolean;
      
      protected var FIsResurrectionOnMove:Boolean;
      
      protected var FFightPetData:TFightPet;
      
      protected var FHint:THint;
      
      protected var FHelpTips:THint;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FCostVect:Vector.<uint>;
      
      protected var FMC_EXP_Earn:MovieClip;
      
      protected var FMC_Coin_Earn:MovieClip;
      
      public var FIsAutoGoldResurgence:Boolean = false;
      
      protected var FGoldlack:Function;
      
      protected var FOnResurrection:Function;
      
      protected var FSetResurrectionStatue:Function;
      
      protected var FOnMoraleUp:Function;
      
      protected var FIsInit:Boolean;
      
      protected var FOnMoraleUpOver:Function;
      
      protected var FOnMoraleUpOut:Function;
      
      protected var FOnHelpOver:Function;
      
      protected var FOnHelpOut:Function;
      
      protected var FUpdateReturnHomePanel:Function;
      
      protected var FStarRun:Function;
      
      protected var FDeathCountdown:Function;
      
      protected var FCloseBtnMe:Function;
      
      public function TLayerOverCopy(param1:TUIComponent)
      {
         super(param1);
         this.FRankList = new Vector.<Sprite>(RankNum);
         this.FCDNumbers = new Vector.<MovieClip>(2);
         this.FEnterTownCDNumbers = new Vector.<MovieClip>(2);
         this.FCharacter = SLogicsCore.Character;
         this.FTimeCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_Animal_DieCd);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FTimeCoolDown);
         this.FFightPetCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_Animal_FIRE);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FFightPetCoolDown);
         this.FMC_EndReward = new TProcessorEndReward(this);
         this.FHint = new THint();
         this.FHelpTips = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_FIGHTPET.RESOURCESID_Swf_FirstRechargeCopy);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Sprite = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_FIGHTPET.RESOURCE_ClassName_FightPetCopy) as Sprite;
         addChild(_loc1_);
         this.FTF_Sliver = _loc1_[CONST_FIGHTPET.RESOURCE_TF_Sliver];
         this.FTF_Gold = _loc1_[CONST_FIGHTPET.RESOURCE_TF_Gold];
         this.FTF_Coupons = _loc1_[CONST_FIGHTPET.RESOURCE_TF_Coupons];
         this.FTF_MyDamage = _loc1_[CONST_FIGHTPET.RESOURCE_TF_MyDamage];
         _loc4_ = RankNum;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = _loc1_[CONST_FIGHTPET.RESOURCE_MC_Rank_ + _loc3_];
            switch(_loc3_)
            {
               case 0:
                  _loc2_["TF_Name"].textColor = CONST_COMMON.QUALITYCOLOR_INDEX[6];
                  _loc2_["TF_Damage"].textColor = CONST_COMMON.QUALITYCOLOR_INDEX[6];
                  break;
               case 1:
                  _loc2_["TF_Name"].textColor = CONST_COMMON.QUALITYCOLOR_INDEX[4];
                  _loc2_["TF_Damage"].textColor = CONST_COMMON.QUALITYCOLOR_INDEX[4];
                  break;
               case 2:
                  _loc2_["TF_Name"].textColor = CONST_COMMON.QUALITYCOLOR_INDEX[3];
                  _loc2_["TF_Damage"].textColor = CONST_COMMON.QUALITYCOLOR_INDEX[3];
                  break;
               default:
                  _loc2_["TF_Name"].textColor = 4294967142;
                  _loc2_["TF_Damage"].textColor = 4294967142;
            }
            this.FRankList[_loc3_] = _loc2_;
            _loc3_++;
         }
         this.FTF_AllPlayer = _loc1_[CONST_FIGHTPET.RESOURCE_TF_AllPlayer];
         this.FMC_Morale = _loc1_[CONST_FIGHTPET.RESOURCE_MC_Morale];
         this.FBT_MoraleUp = _loc1_[CONST_FIGHTPET.RESOURCE_BT_MoraleUp];
         TGameUtil.setButtonMode(this.FBT_MoraleUp,true);
         this.FMC_Description = _loc1_[CONST_FIGHTPET.RESOURCE_MC_Description];
         _loc2_ = _loc1_[CONST_FIGHTPET.RESOURCE_MC_Head];
         this.FTF_MonsterName = _loc2_[CONST_FIGHTPET.RESOURCE_TF_MonsterName];
         this.FTF_HP = _loc2_[CONST_FIGHTPET.RESOURCE_TF_HP];
         this.FMC_Bar = _loc2_[CONST_FIGHTPET.RESOURCE_MC_Bar];
         this.FMC_ColourBar = _loc2_[CONST_FIGHTPET.RESOURCE_MC_ColourBar];
         this.FMC_ColourBarGround = _loc2_[CONST_FIGHTPET.RESOURCE_MC_ColourBarGround];
         this.FMC_BossHead = _loc2_[CONST_FIGHTPET.RESOURCE_MC_BossHead];
         this.FMC_Light = _loc2_[CONST_FIGHTPET.RESOURCE_MC_Light];
         this.FMC_EXP_Earn = MovieClip(_loc1_["MC_EXP_Earn"]);
         this.FMC_Coin_Earn = MovieClip(_loc1_["MC_Coin_Earn"]);
         this.FMC_EXP_Earn.visible = false;
         this.FMC_Coin_Earn.visible = false;
         this.FModalLayer = new Sprite();
         addChild(this.FModalLayer);
         this.FModalLayer.graphics.beginFill(0,0.3);
         this.FModalLayer.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.FModalLayer.graphics.endFill();
         this.FModalLayer.visible = false;
         this.FMC_FightCD = TUtilityReflection.CreateDisplayObjectInstance("MC_FightCDCopy") as Sprite;
         addChild(this.FMC_FightCD);
         this.FMC_FightCD.x = (CONST_COMMON.STAGE_Width - this.FMC_FightCD.width) / 2;
         this.FMC_FightCD.y = (CONST_COMMON.STAGE_Height - this.FMC_FightCD.height) / 2;
         _loc4_ = 2;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FMC_FightCD[CONST_FIGHTPET.RESOURCE_MC_Number_ + _loc3_];
            this.FCDNumbers[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FMC_EnterTownCD = TUtilityReflection.CreateDisplayObjectInstance("MC_EnterTownCDCopy") as Sprite;
         addChild(this.FMC_EnterTownCD);
         this.FMC_EnterTownCD.x = (CONST_COMMON.STAGE_Width - this.FMC_EnterTownCD.width) / 2;
         this.FMC_EnterTownCD.y = (CONST_COMMON.STAGE_Height - this.FMC_EnterTownCD.height) / 2;
         _loc4_ = 2;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FMC_EnterTownCD[CONST_FIGHTPET.RESOURCE_MC_Number_ + _loc3_];
            this.FEnterTownCDNumbers[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FMC_ResurrectionCD = TUtilityReflection.CreateDisplayObjectInstance("MC_ResurrectionCDCopy") as Sprite;
         addChild(this.FMC_ResurrectionCD);
         this.FMC_ResurrectionCD.x = (CONST_COMMON.STAGE_Width - this.FMC_ResurrectionCD.width) / 2;
         this.FMC_ResurrectionCD.y = (CONST_COMMON.STAGE_Height - this.FMC_ResurrectionCD.height) / 2;
         this.FTF_CDNumber = this.FMC_ResurrectionCD[CONST_FIGHTPET.RESOURCE_TF_CDNumber];
         this.FBT_Resurrection = this.FMC_ResurrectionCD[CONST_FIGHTPET.RESOURCE_BT_Resurrection];
         this.FMC_McAutoFire = TUtilityReflection.CreateDisplayObjectInstance(CONST_FIGHTPET.RESOURCE_ClassName_MC_AutoFireCopy) as MovieClip;
         addChild(this.FMC_McAutoFire);
         this.FMC_McAutoFire.visible = false;
         this.FMC_McAutoFire.x = this.FMC_ResurrectionCD.x;
         this.FMC_McAutoFire.y = this.FMC_ResurrectionCD.y - this.FMC_McAutoFire.height;
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         addChild(this.FMC_EndReward);
         this.FMC_EndReward.x = (CONST_COMMON.STAGE_Width - this.FMC_EndReward.width) / 2;
         this.FMC_EndReward.y = (CONST_COMMON.STAGE_Height - this.FMC_EndReward.height) / 2;
         super.ResourcesPerform_UIDispatch();
         var _loc8_:Sprite = TUtilityReflection.CreateDisplayObjectInstance(CONST_FIGHTPET.RESOURCE_ClassName_MC_EndreWARD) as Sprite;
         this.FMC_EndReward.ResourcesPerformh(_loc8_);
         this.FMC_EndReward.x = (CONST_COMMON.STAGE_Width - this.FMC_EndReward.width) / 2;
         this.FMC_EndReward.y = (CONST_COMMON.STAGE_Height - this.FMC_EndReward.height) / 2;
         this.FMC_EndReward.SureBtn = this.SureBtn;
         this.FIsInit = true;
      }
      
      public function set CloseBtnMe(param1:Function) : void
      {
         this.FCloseBtnMe = param1;
      }
      
      protected function SureBtn() : void
      {
         this.FCloseBtnMe();
         this.SetFMC_EndRewardVisible(false);
      }
      
      public function PcloseMe() : void
      {
         this.SetFMC_EndRewardVisible(false);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         super.ResourcesPerform_UILocations();
         this.FBT_MoraleUp.addEventListener(MouseEvent.CLICK,this.MoraleUpOnClick);
         this.FBT_Resurrection.addEventListener(MouseEvent.CLICK,this.ResurrectionOnClick);
         this.FMC_Morale.addEventListener(MouseEvent.MOUSE_MOVE,this.MoraleOnMove);
         this.FMC_Description.addEventListener(MouseEvent.MOUSE_MOVE,this.DescriptionOnMove);
         this.FBT_Resurrection.addEventListener(MouseEvent.MOUSE_MOVE,this.ResurrectionOnMove);
         this.FMC_Morale.addEventListener(MouseEvent.MOUSE_OUT,this.MoraleOnOut);
         this.FMC_Description.addEventListener(MouseEvent.MOUSE_OUT,this.DescriptionOnOut);
         this.FBT_Resurrection.addEventListener(MouseEvent.MOUSE_OUT,this.ResurrectionOnOut);
         this.FConfigValue = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         _loc1_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.KillAnimalBossoneLife) as TConfigValue;
         this.FCostVect = _loc1_.Value as Vector.<uint>;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         super.LogicsPerform();
         if(this.FIsInit)
         {
            this.FTF_Sliver.text = this.FCharacter.CreditSilverCoin.ToString();
            if(this.FCharacter.CreditSilverCoin.ToNumber() / STRING_COMMON.SilverCoinUnit > 1)
            {
               this.FTF_Sliver.text = Math.floor(this.FCharacter.CreditSilverCoin.ToNumber() / STRING_COMMON.SilverCoinUnit).toString() + STRING_COMMON.STRING_Thousand;
            }
            this.FTF_Gold.text = this.FCharacter.CreditGold.toString();
            this.FTF_Coupons.text = this.FCharacter.CreditGiftCertificate.toString();
            if(!this.FFightPetData.GameOver && SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightAnimal)
            {
               this.UpdateActivityColdTime();
            }
            this.FMC_EndReward.updateUI();
         }
         if(this.FIsDie)
         {
            this.FTF_CDNumber.text = this.FTimeCoolDown.TimingTime.toString();
            if(this.FTimeCoolDown.TimingTime == 0)
            {
               this.FIsDie = false;
               this.FMC_ResurrectionCD.visible = false;
               this.FModalLayer.visible = false;
               if(this.FSetResurrectionStatue != null)
               {
                  this.FSetResurrectionStatue();
               }
               if(this.FDeathCountdown != null)
               {
                  this.FDeathCountdown();
               }
               this.FIsResurrectionOnMove = false;
            }
            if(this.FIsResurrectionOnMove)
            {
               _loc1_ = this.FTimeCoolDown.TimingTime;
               _loc2_ = Math.ceil(_loc1_ / 10) * this.GetReviveCost();
               this.FHint.Caption = TUtilityString.Format(STRING_ANIMALSEAL.FORMAT_MONSTER_Resurrection,_loc2_);
               if(this.FOnMoraleUpOver != null)
               {
                  this.FOnMoraleUpOver(this,this.FHint);
               }
            }
            else if(this.FOnMoraleUpOut != null)
            {
               this.FOnMoraleUpOut(this);
            }
         }
      }
      
      protected function GetReviveCost() : int
      {
         if(this.FFightPetData.ReviveTimes < this.FCostVect.length)
         {
            return this.FCostVect[this.FFightPetData.ReviveTimes];
         }
         return this.FCostVect[this.FCostVect.length - 1];
      }
      
      private function WindowInformationOnOK(param1:Object) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate;
         if(_loc2_ < this.FCost)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         if(this.FType == TYPE_MORALE)
         {
            if(this.FOnMoraleUp != null)
            {
               this.FOnMoraleUp();
            }
         }
      }
      
      private function updateMonterInfo(param1:TFightPet) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc5_ = param1.MonsterHP;
         _loc4_ = param1.MonsterTotaleHP;
         this.FTF_MonsterName.text = TUtilityString.Format(STRING_ANIMALSEAL.FORMAT_MONSTER_NAME,param1.MonsterLV,param1.MonsterName);
         this.FTF_HP.text = TUtilityString.Format(STRING_ANIMALSEAL.FORMAT_HP,_loc5_,_loc4_);
         if(_loc5_ > _loc4_ * 0.8)
         {
            this.FMC_ColourBar.gotoAndStop(1);
            this.FMC_ColourBarGround.gotoAndStop(1);
            _loc5_ -= _loc4_ * 0.8;
            _loc3_ = _loc4_ - _loc4_ * 0.8;
         }
         else if(_loc5_ > _loc4_ * 0.6 && _loc5_ <= _loc4_ * 0.8)
         {
            this.FMC_ColourBar.gotoAndStop(2);
            this.FMC_ColourBarGround.gotoAndStop(2);
            _loc5_ -= _loc4_ * 0.6;
            _loc3_ = _loc4_ * 0.8 - _loc4_ * 0.6;
         }
         else if(_loc5_ > _loc4_ * 0.4 && _loc5_ <= _loc4_ * 0.6)
         {
            this.FMC_ColourBar.gotoAndStop(3);
            this.FMC_ColourBarGround.gotoAndStop(3);
            _loc5_ -= _loc4_ * 0.4;
            _loc3_ = _loc4_ * 0.6 - _loc4_ * 0.4;
         }
         else if(_loc5_ > _loc4_ * 0.2 && _loc5_ <= _loc4_ * 0.4)
         {
            this.FMC_ColourBar.gotoAndStop(4);
            this.FMC_ColourBarGround.gotoAndStop(4);
            _loc5_ -= _loc4_ * 0.2;
            _loc3_ = _loc4_ * 0.4 - _loc4_ * 0.2;
         }
         else
         {
            this.FMC_ColourBar.gotoAndStop(5);
            this.FMC_ColourBarGround.gotoAndStop(5);
            _loc5_ = _loc5_;
            _loc3_ = _loc4_ * 0.2;
         }
         _loc2_ = _loc5_ / _loc3_;
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         this.FMC_Bar.scaleX = _loc2_;
         this.FMC_Light.x = this.FMC_Bar.x + this.FMC_Bar.width;
         _loc6_ = this.FFightPetData.MonsterModleID - 12500010;
         this.FMC_BossHead.gotoAndStop(_loc6_ + 1);
      }
      
      private function ResetRankList() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc2_ = RankNum;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FRankList[_loc1_].visible = false;
            _loc1_++;
         }
         this.FTF_MyDamage.visible = false;
      }
      
      private function updateRank(param1:TFightPet) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         this.ResetRankList();
         _loc4_ = param1.MainPlayerDamage.ToNumber();
         _loc5_ = _loc4_ / param1.MonsterTotaleHP * 100;
         this.FTF_MyDamage.text = TUtilityString.Format(STRING_ANIMALSEAL.FORMAT_MONSTER_RANK,_loc4_,_loc5_.toFixed(2));
         this.FTF_MyDamage.visible = true;
         _loc3_ = param1.TopTenRank.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = param1.TopTenRank[_loc2_].Name;
            _loc4_ = param1.TopTenRank[_loc2_].Damage.ToNumber();
            _loc5_ = _loc4_ / param1.MonsterTotaleHP * 100;
            this.FRankList[_loc2_]["TF_Name"].text = TUtilityString.Format(STRING_ANIMALSEAL.FORMAT_MONSTER_RANK_NAME,_loc2_ + 1,_loc6_);
            this.FRankList[_loc2_]["TF_Damage"].text = TUtilityString.Format(STRING_ANIMALSEAL.FORMAT_MONSTER_RANK,_loc4_,_loc5_.toFixed(2));
            this.FRankList[_loc2_].visible = true;
            _loc2_++;
         }
      }
      
      private function updateCDTime(param1:uint) : void
      {
         this.FMC_FightCD.visible = true;
         this.FModalLayer.visible = true;
      }
      
      protected function UpdateActivityColdTime() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 1800;
         if(this.FFightPetCoolDown.TimingTime <= 30 * 60)
         {
            _loc1_ = this.FFightPetCoolDown.TimingTime;
            if(this.FStarRun != null)
            {
               this.FStarRun();
            }
         }
         this.FUpdateReturnHomePanel(this,STRING_ANIMALSEAL.STRING_FightPet,STRING_COMMON.STRING_EndTime + TGameUtil.fomatTime(_loc1_));
      }
      
      private function ResurrectionOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = this.FTimeCoolDown.TimingTime;
         _loc3_ = Math.ceil(_loc2_ / 10);
         if(_loc3_ > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            if(this.FIsAutoGoldResurgence)
            {
               this.FGoldlack();
            }
            else
            {
               this.FUIWindowRecharge.visible = true;
            }
            return;
         }
         if(this.FTimeCoolDown.TimingTime == 0)
         {
            return;
         }
         if(this.FOnResurrection != null)
         {
            this.FOnResurrection();
         }
      }
      
      private function ResurrectionOnOut(param1:MouseEvent) : void
      {
         this.FIsResurrectionOnMove = false;
      }
      
      private function ResurrectionOnMove(param1:MouseEvent) : void
      {
         this.FIsResurrectionOnMove = true;
      }
      
      private function MoraleUpOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TConfigValue = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<Object> = null;
         var _loc8_:Vector.<Object> = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         _loc2_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.KillAnimalBossTimeInspirePrice) as TConfigValue;
         _loc3_ = uint(_loc2_.Value[this.FFightPetData.InspireCount]);
         _loc5_ = "";
         _loc9_ = 0;
         _loc2_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.InspireAttriteExplain) as TConfigValue;
         _loc7_ = _loc2_.Value as Vector.<Object>;
         _loc2_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.InspireAttriteAdd) as TConfigValue;
         _loc8_ = _loc2_.Value as Vector.<Object>;
         _loc11_ = _loc7_.length;
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc9_ = uint(_loc8_[this.FFightPetData.InspireCount][_loc10_]);
            _loc5_ += _loc7_[_loc10_] + "+" + _loc9_.toString() + "% ";
            _loc10_++;
         }
         this.FUIWindowInformation.Text = TUtilityString.Format(STRING_ANIMALSEAL.FORMAT_MONSTER_MoraleUp,_loc3_,_loc5_);
         this.FUIWindowInformation.visible = true;
         this.FType = TYPE_MORALE;
         this.FCost = _loc3_;
      }
      
      private function DescriptionOnMove(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.AnimalSealActiveTip) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         if(this.FOnHelpOver != null)
         {
            this.FOnHelpOver(this,this.FHelpTips);
         }
      }
      
      private function DescriptionOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpOut != null)
         {
            this.FOnHelpOut(this);
         }
      }
      
      private function MoraleOnOut(param1:MouseEvent) : void
      {
         if(this.FOnMoraleUpOut != null)
         {
            this.FOnMoraleUpOut(this);
         }
      }
      
      private function MoraleOnMove(param1:MouseEvent) : void
      {
         var _loc2_:TConfigValue = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<Object> = null;
         var _loc8_:Vector.<Object> = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         _loc5_ = "";
         _loc9_ = 0;
         _loc2_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.InspireAttriteExplain) as TConfigValue;
         _loc7_ = _loc2_.Value as Vector.<Object>;
         _loc2_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.InspireAttriteAdd) as TConfigValue;
         _loc8_ = _loc2_.Value as Vector.<Object>;
         _loc11_ = _loc7_.length;
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            if(this.FFightPetData.InspireCount == 0)
            {
               _loc9_ = 0;
            }
            else
            {
               _loc9_ = uint(_loc8_[this.FFightPetData.InspireCount - 1][_loc10_]);
            }
            _loc5_ += _loc7_[_loc10_] + "+" + _loc9_.toString() + "%\n";
            _loc10_++;
         }
         this.FHint.Caption = _loc5_;
         if(this.FOnMoraleUpOver != null)
         {
            this.FOnMoraleUpOver(this,this.FHint);
         }
      }
      
      public function get TotalHP() : uint
      {
         return this.FTotalHP;
      }
      
      public function set TotalHP(param1:uint) : void
      {
         this.FTotalHP = param1;
      }
      
      public function get OnResurrection() : Function
      {
         return this.FOnResurrection;
      }
      
      public function set OnResurrection(param1:Function) : void
      {
         this.FOnResurrection = param1;
      }
      
      public function get OnMoraleUp() : Function
      {
         return this.FOnMoraleUp;
      }
      
      public function set OnMoraleUp(param1:Function) : void
      {
         this.FOnMoraleUp = param1;
      }
      
      public function get IsInit() : Boolean
      {
         return this.FIsInit;
      }
      
      public function set FightPetData(param1:TFightPet) : void
      {
         this.FFightPetData = param1;
      }
      
      public function get OnMoraleUpOver() : Function
      {
         return this.FOnMoraleUpOver;
      }
      
      public function set OnMoraleUpOver(param1:Function) : void
      {
         this.FOnMoraleUpOver = param1;
      }
      
      public function get OnMoraleUpOut() : Function
      {
         return this.FOnMoraleUpOut;
      }
      
      public function set OnMoraleUpOut(param1:Function) : void
      {
         this.FOnMoraleUpOut = param1;
      }
      
      public function get SetResurrectionStatue() : Function
      {
         return this.FSetResurrectionStatue;
      }
      
      public function set SetResurrectionStatue(param1:Function) : void
      {
         this.FSetResurrectionStatue = param1;
      }
      
      public function set UpdateReturnHomePanel(param1:Function) : void
      {
         this.FUpdateReturnHomePanel = param1;
      }
      
      public function set FightPetCoolDown(param1:uint) : void
      {
         this.FFightPetCoolDown.TimingTime = param1;
      }
      
      public function get OnHelpOver() : Function
      {
         return this.FOnHelpOver;
      }
      
      public function set OnHelpOver(param1:Function) : void
      {
         this.FOnHelpOver = param1;
      }
      
      public function get OnHelpOut() : Function
      {
         return this.FOnHelpOut;
      }
      
      public function set OnHelpOut(param1:Function) : void
      {
         this.FOnHelpOut = param1;
      }
      
      public function set StarRun(param1:Function) : void
      {
         this.FStarRun = param1;
      }
      
      public function set DeathCountdown(param1:Function) : void
      {
         this.FDeathCountdown = param1;
      }
      
      public function set Goldlack(param1:Function) : void
      {
         this.FGoldlack = param1;
      }
      
      public function updateMonster(param1:TFightPet) : void
      {
         this.updateMonterInfo(param1);
      }
      
      public function updatePlayerNum(param1:uint) : void
      {
         this.FTF_AllPlayer.text = param1.toString();
      }
      
      public function init(param1:TFightPet) : void
      {
         this.FMC_ResurrectionCD.visible = false;
         this.FMC_FightCD.visible = false;
         this.FMC_EnterTownCD.visible = false;
         this.updateMonterInfo(param1);
         this.updateRank(param1);
         this.FTF_AllPlayer.text = param1.AllplayerCount.toString();
         this.updateInspire();
         this.ReflashRoleState(param1.RoleExpCoinState);
      }
      
      public function SetVisibelFire(param1:Boolean) : void
      {
         if(this.FMC_McAutoFire)
         {
            if(param1)
            {
               this.FMC_McAutoFire.gotoAndPlay(1);
            }
            else
            {
               this.FMC_McAutoFire.gotoAndStop(1);
            }
            this.FMC_McAutoFire.visible = param1;
         }
      }
      
      public function ReflashRoleState(param1:uint) : void
      {
         this.FMC_Coin_Earn.visible = false;
         this.FMC_EXP_Earn.visible = false;
         this.FMC_Coin_Earn.visible = Boolean(param1 & 1);
         this.FMC_EXP_Earn.visible = Boolean(param1 & 0x10);
      }
      
      public function RankUpdate(param1:TFightPet) : void
      {
         this.updateRank(param1);
      }
      
      public function DieCDUpdate(param1:uint) : void
      {
         this.FTimeCoolDown.TimingTime = param1;
         this.FIsDie = true;
      }
      
      public function BattleBackUpdate() : void
      {
         if(this.FTimeCoolDown.TimingTime > 0)
         {
            this.FMC_ResurrectionCD.visible = true;
            this.FModalLayer.visible = true;
            if(this.FIsAutoGoldResurgence)
            {
               this.ResurrectionOnClick(null);
            }
         }
         else
         {
            this.FMC_ResurrectionCD.visible = false;
            this.FModalLayer.visible = false;
         }
         if(this.FFightPetData.GameOver)
         {
            this.FMC_ResurrectionCD.visible = false;
            this.FModalLayer.visible = false;
         }
      }
      
      public function SetFMC_EndRewardVisible(param1:Boolean) : void
      {
         this.FMC_EndReward.visible = param1;
         this.FModalLayer.visible = param1;
      }
      
      public function InfoCDUpdate(param1:uint) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         if(param1 == 0)
         {
            this.FMC_FightCD.visible = false;
            this.FModalLayer.visible = false;
         }
         else
         {
            this.FMC_FightCD.visible = true;
            this.FModalLayer.visible = true;
            _loc3_ = Math.floor(param1 / 10);
            this.FCDNumbers[0].gotoAndStop(_loc3_ + 1);
            _loc3_ = param1 % 10;
            this.FCDNumbers[1].gotoAndStop(_loc3_ + 1);
         }
      }
      
      public function BackTownCDUpdate(param1:uint) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         if(param1 == 0)
         {
            this.FMC_EnterTownCD.visible = false;
            this.FModalLayer.visible = false;
         }
         else
         {
            this.FMC_EnterTownCD.visible = true;
            this.FMC_FightCD.visible = false;
            this.FModalLayer.visible = false;
            _loc3_ = Math.floor(param1 / 10);
            this.FEnterTownCDNumbers[0].gotoAndStop(_loc3_ + 1);
            _loc3_ = param1 % 10;
            this.FEnterTownCDNumbers[1].gotoAndStop(_loc3_ + 1);
         }
      }
      
      public function Resurrection() : void
      {
         this.FTimeCoolDown.TimingTime = 0;
      }
      
      public function updateInspire() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.KillAnimalBossTimeInspirePrice) as TConfigValue;
         if(this.FFightPetData.InspireCount == _loc1_.Value.length)
         {
            TGameUtil.setMovieClipButton(this.FBT_MoraleUp,false);
            this.FBT_MoraleUp.mouseEnabled = false;
         }
         else
         {
            TGameUtil.setMovieClipButton(this.FBT_MoraleUp,true);
            this.FBT_MoraleUp.mouseEnabled = true;
         }
      }
   }
}

