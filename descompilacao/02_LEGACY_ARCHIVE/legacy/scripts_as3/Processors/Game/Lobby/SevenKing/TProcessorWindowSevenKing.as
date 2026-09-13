package Processors.Game.Lobby.SevenKing
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TSevenHeroSoul;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Display.TEffectBaseFlicker;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSevenKing extends TUIComponent
   {
      
      protected static const CONST_SOUL:int = CONST_COMMON.CAPACITY_KingSouls;
      
      protected static const CAPACITY_Credits:int = CONST_CHARACTER.CAPACITY_Credits - 3;
      
      protected static const CREDITINDEX_Gold:int = CONST_CHARACTER.CREDITINDEX_Gold;
      
      protected static const CREDITINDEX_SilverCoin:int = CONST_CHARACTER.CREDITINDEX_SilverCoin;
      
      protected static const CREDITINDEX_GiftCertificate:int = CONST_CHARACTER.CREDITINDEX_GiftCertificate;
      
      protected var FHelpTips:THint;
      
      protected var FHintSilverCoin:THint;
      
      protected var FScene:MovieClip;
      
      protected var FCharacter:TCharacter;
      
      protected var FCredits:Vector.<Object>;
      
      protected var FHeroSouls:Vector.<uint>;
      
      protected var FEffectFlickerCredits:Vector.<TEffectBaseFlicker>;
      
      protected var FEffectFlickerSoul:Vector.<TEffectBaseFlicker>;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnEnterCity:Function;
      
      protected var FEffectGenerateText:Function;
      
      protected var FUIComponentsOnOver:Function;
      
      protected var FUIComponentsOnOut:Function;
      
      public function TProcessorWindowSevenKing(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:uint = 0;
         var _loc4_:TEffectBaseFlicker = null;
         var _loc5_:uint = 0;
         var _loc6_:MovieClip = null;
         super(param1);
         this.FHelpTips = new THint();
         this.FHintSilverCoin = new THint();
         this.FScene = param2;
         this.FCharacter = SLogicsCore.Character;
         this.FScene.mc_autoPoint.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseTavern);
         this.FScene.mc_autoPoint.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FScene.mc_autoPoint.btn_help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FScene.tf_silverCoin.addEventListener(MouseEvent.MOUSE_MOVE,this.TF_SilverCoinOnMove,false,0,true);
         this.FScene.tf_silverCoin.addEventListener(MouseEvent.MOUSE_OUT,this.TF_SilverCoinOnOut,false,0,true);
         this.FCredits = new Vector.<Object>(CAPACITY_Credits);
         this.FCredits[CREDITINDEX_SilverCoin] = new UInt64();
         this.FHeroSouls = new Vector.<uint>(CONST_SOUL);
         this.FEffectFlickerCredits = new Vector.<TEffectBaseFlicker>(CAPACITY_Credits);
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_Credits)
         {
            _loc4_ = new TEffectBaseFlicker();
            this.FEffectFlickerCredits[_loc3_] = _loc4_;
            _loc3_++;
         }
         this.FEffectFlickerSoul = new Vector.<TEffectBaseFlicker>(CONST_SOUL);
         _loc3_ = 0;
         while(_loc3_ < CONST_SOUL)
         {
            _loc4_ = new TEffectBaseFlicker();
            this.FEffectFlickerSoul[_loc3_] = _loc4_;
            _loc3_++;
         }
         _loc5_ = uint(CONST_SOUL);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc6_ = this.FScene.parent["MC_KingSoul_" + _loc3_];
            _loc6_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCKingSoulOnOver,false,0,true);
            _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.MCKingSoulOnOut,false,0,true);
            _loc3_++;
         }
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
         return this.FScene["tf_Soul_" + param1];
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
         _loc2_ = CONST_SOUL;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = parseInt(this.GetTFHeroSoulByIndex(_loc1_).text);
            _loc7_ = this.FEffectFlickerSoul[_loc1_];
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
         _loc2_ = int(this.FEffectFlickerSoul.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEffectFlickerSoul[_loc1_];
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
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_SevenKing) as TSystemLanguage;
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
      
      protected function MCKingSoulOnOut(param1:MouseEvent) : void
      {
         if(this.FUIComponentsOnOut != null)
         {
            this.FUIComponentsOnOut(this);
         }
      }
      
      protected function MCKingSoulOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TSevenHeroSoul = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TBins = null;
         var _loc7_:uint = 0;
         _loc5_ = param1.currentTarget as MovieClip;
         _loc7_ = parseInt(_loc5_.name.split("_")[2]) + 1;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SevenHeroSoul) as TBins;
         _loc3_ = uint(_loc6_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc6_.GetDatebaseByIndex(_loc2_) as TSevenHeroSoul;
            if(_loc4_.Identifier % 10 == _loc7_ || _loc7_ == _loc3_)
            {
               if(this.FUIComponentsOnOver != null)
               {
                  this.FUIComponentsOnOver(this,_loc4_);
               }
            }
            _loc2_++;
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
      
      public function GetHeroSoulByIndex(param1:int) : uint
      {
         return this.FHeroSouls[param1];
      }
      
      public function SetHeroSoulByIndex(param1:int, param2:uint) : void
      {
         this.FHeroSouls[param1] = param2;
      }
      
      public function get UIComponentsOnOver() : Function
      {
         return this.FUIComponentsOnOver;
      }
      
      public function set UIComponentsOnOver(param1:Function) : void
      {
         this.FUIComponentsOnOver = param1;
      }
      
      public function get UIComponentsOnOut() : Function
      {
         return this.FUIComponentsOnOut;
      }
      
      public function set UIComponentsOnOut(param1:Function) : void
      {
         this.FUIComponentsOnOut = param1;
      }
      
      public function UpdataPublicUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         if(this.FCharacter.CreditSilverCoin.ToNumber() > STRING_COMMON.SilverCoinUnit)
         {
            _loc2_ = Math.floor(this.FCharacter.CreditSilverCoin.ToNumber() * STRING_COMMON.SilverCoinCoefficient) + STRING_COMMON.STRING_Thousand;
         }
         else
         {
            _loc2_ = this.FCharacter.CreditSilverCoin.ToString();
         }
         this.FScene.tf_silverCoin.text = _loc2_;
         this.FScene.tf_gold.text = this.FCharacter.CreditGold.toString();
         this.FScene.tf_giftCertificate.text = this.FCharacter.CreditGiftCertificate.toString();
         _loc1_ = 0;
         while(_loc1_ < CONST_SOUL)
         {
            _loc3_ = this.FCharacter.GetKingSoulByIndex(_loc1_);
            this.FScene["tf_Soul_" + _loc1_].text = _loc3_;
            this.FHeroSouls[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      public function UpdataEffect() : void
      {
         this.LogicsPerform_CreditsEffect();
      }
   }
}

