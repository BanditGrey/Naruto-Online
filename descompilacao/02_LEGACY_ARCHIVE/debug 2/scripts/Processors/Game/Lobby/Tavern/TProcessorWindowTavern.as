package Processors.Game.Lobby.Tavern
{
   import Foundation.Common.*;
   import Foundation.Common.Integer.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Tavern.TReportList;
   import Processors.Game.Common.Effects.Display.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TProcessorWindowTavern extends TUIComponent
   {
      
      protected static const MAX_REPORTCOUNT:uint = 10;
      
      protected static const CAPACITY_Credits:int = CONST_CHARACTER.CAPACITY_Credits - 3;
      
      protected static const CREDITINDEX_Gold:int = CONST_CHARACTER.CREDITINDEX_Gold;
      
      protected static const CREDITINDEX_SilverCoin:int = CONST_CHARACTER.CREDITINDEX_SilverCoin;
      
      protected static const CREDITINDEX_GiftCertificate:int = CONST_CHARACTER.CREDITINDEX_GiftCertificate;
      
      public static const CAPACITY_HeroSouls:int = CONST_CHARACTER.CAPACITY_HeroSouls;
      
      public static const HEROSOULINDEX_BlueSoul:int = CONST_CHARACTER.HEROSOULINDEX_BlueSoul;
      
      public static const HEROSOULINDEX_PurpleSoul:int = CONST_CHARACTER.HEROSOULINDEX_PurpleSoul;
      
      public static const HEROSOULINDEX_GoldSoul:int = CONST_CHARACTER.HEROSOULINDEX_GoldSoul;
      
      public static const HEROSOULINDEX_OrangeSoul:int = CONST_CHARACTER.HEROSOULINDEX_OrangeSoul;
      
      protected var FHelpTips:THint;
      
      protected var FScene:MovieClip;
      
      protected var FCharacter:TCharacter;
      
      protected var FHintSilverCoin:THint;
      
      protected var FCredits:Vector.<Object>;
      
      protected var FHeroSouls:Vector.<uint>;
      
      protected var FEffectFlickerCredits:Vector.<TEffectBaseFlicker>;
      
      protected var FEffectFlickerHeroSouls:Vector.<TEffectBaseFlicker>;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnEnterCity:Function;
      
      protected var FEffectGenerateText:Function;
      
      public function TProcessorWindowTavern(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:uint = 0;
         var _loc4_:TEffectBaseFlicker = null;
         super(param1);
         this.FHelpTips = new THint();
         this.FScene = param2;
         this.FCharacter = SLogicsCore.Character;
         this.FScene.btn_addSilverCoin.addEventListener(MouseEvent.CLICK,this.OnAddSilverCoin);
         this.FScene.mc_autoPoint.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseTavern);
         this.FScene.mc_autoPoint.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FScene.mc_autoPoint.btn_help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FScene.tf_silverCoin.addEventListener(MouseEvent.MOUSE_MOVE,this.TF_SilverCoinOnMove,false,0,true);
         this.FScene.tf_silverCoin.addEventListener(MouseEvent.MOUSE_OUT,this.TF_SilverCoinOnOut,false,0,true);
         this.FScene.tf_blueSoul.addEventListener(MouseEvent.MOUSE_MOVE,this.FiveMove);
         this.FScene.tf_blueSoul.addEventListener(MouseEvent.MOUSE_OUT,this.FiveOut);
         this.FScene.tf_purpleSoul.addEventListener(MouseEvent.MOUSE_MOVE,this.FiveMove);
         this.FScene.tf_purpleSoul.addEventListener(MouseEvent.MOUSE_OUT,this.FiveOut);
         this.FScene.tf_goldSoul.addEventListener(MouseEvent.MOUSE_MOVE,this.FiveMove);
         this.FScene.tf_goldSoul.addEventListener(MouseEvent.MOUSE_OUT,this.FiveOut);
         this.FScene.tf_orangeSoul.addEventListener(MouseEvent.MOUSE_MOVE,this.FiveMove);
         this.FScene.tf_orangeSoul.addEventListener(MouseEvent.MOUSE_OUT,this.FiveOut);
         this.FHintSilverCoin = new THint();
         this.FCredits = new Vector.<Object>(CAPACITY_Credits);
         this.FCredits[CREDITINDEX_SilverCoin] = new UInt64();
         this.FHeroSouls = new Vector.<uint>(CAPACITY_HeroSouls);
         this.FEffectFlickerCredits = new Vector.<TEffectBaseFlicker>(CAPACITY_Credits);
         this.FEffectFlickerHeroSouls = new Vector.<TEffectBaseFlicker>(CAPACITY_HeroSouls);
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_Credits)
         {
            _loc4_ = new TEffectBaseFlicker();
            this.FEffectFlickerCredits[_loc3_] = _loc4_;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_HeroSouls)
         {
            _loc4_ = new TEffectBaseFlicker();
            this.FEffectFlickerHeroSouls[_loc3_] = _loc4_;
            _loc3_++;
         }
         this.FScene.mc_moraLog.tf_moraLog.text = "";
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
      
      protected function GetTFHeroSoulByIndex(param1:uint) : TextField
      {
         switch(param1)
         {
            case HEROSOULINDEX_BlueSoul:
               return this.FScene.tf_blueSoul;
            case HEROSOULINDEX_PurpleSoul:
               return this.FScene.tf_purpleSoul;
            case HEROSOULINDEX_GoldSoul:
               return this.FScene.tf_goldSoul;
            case HEROSOULINDEX_OrangeSoul:
               return this.FScene.tf_orangeSoul;
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
         _loc2_ = CAPACITY_HeroSouls;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = parseInt(this.GetTFHeroSoulByIndex(_loc1_).text);
            _loc7_ = this.FEffectFlickerHeroSouls[_loc1_];
            if(_loc6_ != this.GetHeroSoulByIndex(_loc1_) && _loc7_.IsRunOver)
            {
               _loc7_.SetParameters(this.GetTFHeroSoulByIndex(_loc1_));
            }
            _loc8_ = Math.ceil(Math.abs(this.GetHeroSoulByIndex(_loc1_) - _loc6_) / 2);
            if(_loc6_ > this.GetHeroSoulByIndex(_loc1_))
            {
               _loc6_ -= _loc8_;
            }
            else if(_loc6_ < this.GetHeroSoulByIndex(_loc1_))
            {
               _loc6_ += _loc8_;
            }
            this.GetTFHeroSoulByIndex(_loc1_).text = _loc6_.toString();
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
         _loc2_ = int(this.FEffectFlickerHeroSouls.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEffectFlickerHeroSouls[_loc1_];
            if(!_loc3_.IsRunOver)
            {
               _loc3_.Run();
            }
            _loc1_++;
         }
      }
      
      override protected function ProcessorResize() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = FUICore.StageWidth;
         if(this.FScene != null)
         {
            this.FScene.mc_autoPoint.x = _loc1_;
         }
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      protected function OnAddSilverCoin(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Ramen);
         }
      }
      
      protected function OnCloseTavern(param1:MouseEvent) : void
      {
         if(this.FOnEnterCity != null)
         {
            this.FOnEnterCity(this);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Tavern) as TSystemLanguage;
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
      
      protected function TF_SilverCoinOnMove(param1:MouseEvent) : void
      {
         this.FHintSilverCoin.Caption = this.FCharacter.CreditSilverCoin.ToString();
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintSilverCoin);
         }
      }
      
      protected function TF_SilverCoinOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function FiveMove(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         var _loc3_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FScene.tf_blueSoul:
               _loc3_ = int(CONST_SYSTEMLANGUAGE.HELPTIPS_TevanNew1);
               break;
            case this.FScene.tf_purpleSoul:
               _loc3_ = int(CONST_SYSTEMLANGUAGE.HELPTIPS_TevanNew2);
               break;
            case this.FScene.tf_goldSoul:
               _loc3_ = int(CONST_SYSTEMLANGUAGE.HELPTIPS_TevanNew3);
               break;
            case this.FScene.tf_orangeSoul:
               _loc3_ = int(CONST_SYSTEMLANGUAGE.HELPTIPS_TevanNew4);
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc3_) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         if(this.FOnHelpTipsOver != null)
         {
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function FiveOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
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
      
      public function GetHeroSoulByIndex(param1:int) : uint
      {
         return this.FHeroSouls[param1];
      }
      
      public function SetHeroSoulByIndex(param1:int, param2:uint) : void
      {
         this.FHeroSouls[param1] = param2;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.visible = param1;
      }
      
      override public function get Visible() : Boolean
      {
         if(this.FScene == null)
         {
            return false;
         }
         return this.FScene.visible;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
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
      
      public function set OnEnterCity(param1:Function) : void
      {
         this.FOnEnterCity = param1;
      }
      
      public function get OnEnterCity() : Function
      {
         return this.FOnEnterCity;
      }
      
      public function set EffectGenerateText(param1:Function) : void
      {
         this.FEffectGenerateText = param1;
      }
      
      public function get EffectGenerateText() : Function
      {
         return this.FEffectGenerateText;
      }
      
      public function UpdataPublicUI() : void
      {
         var _loc1_:String = null;
         if(this.FCharacter.CreditSilverCoin.ToNumber() > STRING_COMMON.SilverCoinUnit)
         {
            _loc1_ = Math.floor(this.FCharacter.CreditSilverCoin.ToNumber() * STRING_COMMON.SilverCoinCoefficient) + STRING_COMMON.STRING_Thousand;
         }
         else
         {
            _loc1_ = this.FCharacter.CreditSilverCoin.ToString();
         }
         this.FScene.tf_silverCoin.text = _loc1_;
         this.FScene.tf_gold.text = this.FCharacter.CreditGold.toString();
         this.FScene.tf_giftCertificate.text = this.FCharacter.CreditGiftCertificate.toString();
         this.FScene.tf_blueSoul.text = this.FCharacter.HeroSoulBlueSoul.toString();
         this.FScene.tf_purpleSoul.text = this.FCharacter.HeroSoulPurpleSoul.toString();
         this.FScene.tf_goldSoul.text = this.FCharacter.HeroSoulGoldSoul.toString();
         this.FScene.tf_orangeSoul.text = this.FCharacter.HeroSoulOrangeSoul.toString();
         this.FHeroSouls[0] = this.FCharacter.HeroSoulBlueSoul;
         this.FHeroSouls[1] = this.FCharacter.HeroSoulPurpleSoul;
         this.FHeroSouls[2] = this.FCharacter.HeroSoulGoldSoul;
         this.FHeroSouls[3] = this.FCharacter.HeroSoulOrangeSoul;
      }
      
      public function UpdataEffect() : void
      {
         this.LogicsPerform_CreditsEffect();
      }
      
      public function ResetMoraLog(param1:Vector.<TReportList>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TReportList = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         _loc5_ = "";
         _loc3_ = param1.length;
         _loc2_ = Math.max(0,_loc3_ - MAX_REPORTCOUNT);
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1[_loc2_];
            _loc5_ = (_loc2_ == _loc3_ - 1 ? "" : "\n") + TUtilityString.Format(STRING_TAVERN.MoraReportLog,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_.Time) * 1000)),STRING_TAVERN.MoraTypeVect[_loc4_.MoraType],STRING_TAVERN.ColorDescription[_loc4_.SoulType],_loc4_.SoulCount) + _loc5_;
            _loc2_++;
         }
         this.FScene.mc_moraLog.tf_moraLog.htmlText = _loc5_;
      }
      
      public function EnableBtn(param1:Boolean) : void
      {
         this.FScene.mouseEnabled = param1;
         this.FScene.mouseChildren = param1;
      }
   }
}

