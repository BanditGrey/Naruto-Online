package Processors.Game.Lobby.TraitorAttack
{
   import Foundation.Common.*;
   import Foundation.Common.Integer.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.TraitorAttack.*;
   import Processors.Game.*;
   import Processors.Game.Common.Effects.Display.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TProcessorWindowTraitorAttack extends TProcessorGame
   {
      
      protected static const MaxCount_Family:uint = 3;
      
      protected static const MaxCount_Hero:uint = 10;
      
      protected static const CAPACITY_Credits:int = CONST_CHARACTER.CAPACITY_Credits - 3;
      
      protected static const CREDITINDEX_Gold:int = CONST_CHARACTER.CREDITINDEX_Gold;
      
      protected static const CREDITINDEX_SilverCoin:int = CONST_CHARACTER.CREDITINDEX_SilverCoin;
      
      protected static const CREDITINDEX_GiftCertificate:int = CONST_CHARACTER.CREDITINDEX_GiftCertificate;
      
      protected var FScene:MovieClip;
      
      protected var FCredits:Vector.<Object>;
      
      protected var FEffectFlickerCredits:Vector.<TEffectBaseFlicker>;
      
      protected var FTraitorAttackData:TTraitorAttackData;
      
      protected var FCharacter:TCharacter;
      
      protected var FAttackIndex:uint;
      
      protected var FAttackIndexMax:uint;
      
      protected var FAttackBuff:int;
      
      protected var FAttackNeed:Vector.<uint>;
      
      protected var FHint:THint;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHelpHintOnOver:Function;
      
      protected var FHelpHintOnOut:Function;
      
      public function TProcessorWindowTraitorAttack(param1:TUIComponent)
      {
         var _loc2_:uint = 0;
         var _loc3_:TEffectBaseFlicker = null;
         super(param1);
         this.FCredits = new Vector.<Object>(CAPACITY_Credits);
         this.FCredits[CREDITINDEX_SilverCoin] = new UInt64();
         this.FEffectFlickerCredits = new Vector.<TEffectBaseFlicker>(CAPACITY_Credits);
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_Credits)
         {
            _loc3_ = new TEffectBaseFlicker();
            this.FEffectFlickerCredits[_loc2_] = _loc3_;
            _loc2_++;
         }
         this.FCharacter = SLogicsCore.Character;
         this.FHint = new THint();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FCharacter.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TraitorAttack)
         {
            this.LogicsPerform_CreditsEffect();
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
               this.FScene.tf_SilverCoin.text = _loc4_;
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
      
      protected function GetTFCreditByIndex(param1:uint) : TextField
      {
         switch(param1)
         {
            case CREDITINDEX_Gold:
               return this.FScene.tf_CreditGold;
            case CREDITINDEX_SilverCoin:
               return this.FScene.tf_SilverCoin;
            case CREDITINDEX_GiftCertificate:
               return this.FScene.tf_GiftCertificate;
            default:
               return null;
         }
      }
      
      protected function GetTextColor(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = CONST_COMMON.QUALITYCOLOR_INDEX[6];
               break;
            case 1:
               _loc2_ = CONST_COMMON.QUALITYCOLOR_INDEX[4];
               break;
            case 2:
               _loc2_ = CONST_COMMON.QUALITYCOLOR_INDEX[3];
         }
         return _loc2_;
      }
      
      protected function GetHarmAttackIndex(param1:Number) : uint
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FAttackNeed.length)
         {
            if(param1 < this.FAttackNeed[_loc2_])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return _loc2_;
      }
      
      protected function SilverCoinOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnOver != null)
         {
            this.FHint.Caption = this.CreditSilverCoin.ToString();
            this.FHintOnOver(param1,this.FHint);
         }
      }
      
      protected function SilverCoinOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function OnHintMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = STRING_TRAITORATTACK.STRING_Activity_Buff;
         _loc2_ = _loc2_.split("%lv%").join(this.FAttackIndex * this.FAttackBuff);
         this.FHint.Caption = _loc2_;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(param1,this.FHint);
         }
      }
      
      protected function OnHintOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function OnHintActivityDescMove(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FHelpHintOnOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TRAITORATTACK) as TSystemLanguage;
            this.FHint.Content = _loc2_.Desc;
            this.FHelpHintOnOver(this,this.FHint);
         }
      }
      
      protected function OnHintActivityDescOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
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
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HelpHintOnOver() : Function
      {
         return this.FHelpHintOnOver;
      }
      
      public function set HelpHintOnOver(param1:Function) : void
      {
         this.FHelpHintOnOver = param1;
      }
      
      public function get HelpHintOnOut() : Function
      {
         return this.FHelpHintOnOut;
      }
      
      public function set HelpHintOnOut(param1:Function) : void
      {
         this.FHelpHintOnOut = param1;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         this.FScene = param1;
         addChild(this.FScene);
      }
      
      public function InitUI(param1:TTraitorAttackData) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TConfigValue = null;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TraitorAttack_Attackneed) as TConfigValue;
         this.FAttackNeed = _loc6_.Value as Vector.<uint>;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TraitorAttack_Attackbuff) as TConfigValue;
         this.FAttackBuff = _loc6_.Value as int;
         this.FTraitorAttackData = param1;
         if(this.FCharacter.CreditSilverCoin.ToNumber() > STRING_COMMON.SilverCoinUnit)
         {
            _loc3_ = Math.floor(this.FCharacter.CreditSilverCoin.ToNumber() * STRING_COMMON.SilverCoinCoefficient) + STRING_COMMON.STRING_Thousand;
         }
         else
         {
            _loc3_ = this.FCharacter.CreditSilverCoin.ToString();
         }
         this.FScene.tf_SilverCoin.addEventListener(MouseEvent.MOUSE_MOVE,this.SilverCoinOnMove);
         this.FScene.tf_SilverCoin.addEventListener(MouseEvent.ROLL_OUT,this.SilverCoinOnOut);
         this.FScene.tf_SilverCoin.text = _loc3_;
         this.FScene.tf_CreditGold.text = this.FCharacter.CreditGold.toString();
         this.FScene.tf_GiftCertificate.text = this.FCharacter.CreditGiftCertificate.toString();
         (this.GetCreditByIndex(CREDITINDEX_SilverCoin) as UInt64).High = this.FCharacter.CreditSilverCoin.High;
         (this.GetCreditByIndex(CREDITINDEX_SilverCoin) as UInt64).Low = this.FCharacter.CreditSilverCoin.Low;
         this.SetCreditByIndex(CREDITINDEX_Gold,this.FCharacter.CreditGold);
         this.SetCreditByIndex(CREDITINDEX_GiftCertificate,this.FCharacter.CreditGiftCertificate);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc5_ = this.FScene["mc_Rank_" + _loc4_];
            _loc2_ = this.GetTextColor(_loc4_);
            _loc5_.tf_Name.textColor = _loc2_;
            _loc5_.tf_Damage.textColor = _loc2_;
            _loc4_++;
         }
         this.FScene.mc_activity.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHintActivityDescMove);
         this.FScene.mc_activity.addEventListener(MouseEvent.ROLL_OUT,this.OnHintActivityDescOut);
         this.FScene.mc_attackBuff.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHintMove);
         this.FScene.mc_attackBuff.addEventListener(MouseEvent.ROLL_OUT,this.OnHintOut);
      }
      
      public function UpdataRankUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:String = null;
         var _loc4_:TTraitorAttackRankHero = null;
         var _loc5_:TTraitorAttackRankHeros = null;
         _loc5_ = this.FTraitorAttackData.RankList;
         _loc1_ = 0;
         while(_loc1_ < MaxCount_Hero)
         {
            _loc2_ = this.FScene["mc_Rank_" + _loc1_];
            _loc2_.mouseEnabled = false;
            if(_loc1_ < _loc5_.Count)
            {
               _loc2_.visible = true;
               _loc4_ = _loc5_.GetRankHeroByIndex(_loc1_);
               _loc2_.tf_Name.text = _loc1_ + 1 + ". " + _loc4_.HeroName;
               _loc2_.tf_Damage.text = _loc4_.HeroHarm.ToString();
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         this.FScene.tf_MyDamage.text = this.FTraitorAttackData.RankList.MySelfHarm.ToString();
         this.FScene.tf_TotleDamage.text = this.FTraitorAttackData.RankList.TotleHarm.ToString();
         this.FAttackIndex = this.GetHarmAttackIndex(this.FTraitorAttackData.RankList.TotleHarm.ToNumber());
         this.FAttackIndexMax = this.FAttackNeed.length;
         if(this.FAttackIndex >= this.FAttackIndexMax)
         {
            _loc3_ = STRING_TRAITORATTACK.STRING_Activity_MaxBuff;
         }
         else
         {
            _loc3_ = STRING_TRAITORATTACK.STRING_Activity_BuffTip;
            _loc3_ = _loc3_.split("%count%").join(this.FAttackNeed[this.FAttackIndex]);
            _loc3_ = _loc3_.split("%lv%").join(this.FAttackBuff * (this.FAttackIndex + 1));
         }
         this.FScene.tf_tips.text = _loc3_;
      }
      
      public function UpdataScoreUI() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < MaxCount_Family)
         {
            this.FScene["tf_BattlePower_" + _loc1_].text = String(this.FTraitorAttackData.ScoreList[_loc1_]);
            _loc1_++;
         }
      }
      
      public function UpdataWave() : void
      {
         var _loc1_:String = null;
         _loc1_ = STRING_TRAITORATTACK.STRING_Activity_Wave;
         _loc1_ = _loc1_.split("%count%").join(this.FTraitorAttackData.CurWave);
         this.FScene.tf_Wave.text = _loc1_;
      }
      
      public function UpdataPlayerCountUI() : void
      {
         this.FScene.tf_AllPlayer.text = String(this.FTraitorAttackData.EnterHeroCount);
      }
   }
}

