package Processors.Game.Lobby.Talent.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Talent.TTalentGifts;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUITalentGifts extends TUIComponent
   {
      
      protected static const GIFTS_NORMAL:int = 1;
      
      protected static const GIFTS_TOPUP:int = 2;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUIReward:TUIBaseBox;
      
      protected var FUISpecReward:TUIBaseBox;
      
      protected var FTalentGifts:TTalentGifts;
      
      protected var FEffectGlow:TEffectBaseGlow;
      
      public var OnRewardTalentGift:Function;
      
      public var OnHintOver:Function;
      
      public var OnHintOut:Function;
      
      public function TUITalentGifts(param1:TUIComponent)
      {
         super(param1);
         this.UIResourceDispatch();
      }
      
      protected function UIResourceDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("box_talentGifts") as MovieClip;
         addChild(this.FMC_Scene);
         this.FUIReward = new TUIBaseBox(this,2);
         this.FUIReward.Perform_UIDispatch(this.FMC_Scene["MC_Award"]);
         this.FUIReward.OnOverlay = this.PerformOnOverlay;
         this.FUIReward.OnOut = this.PerformOnOut;
         this.FUISpecReward = new TUIBaseBox(this,2);
         this.FUISpecReward.Perform_UIDispatch(this.FMC_Scene["MC_SpeciAward"]);
         this.FUISpecReward.OnOverlay = this.PerformOnOverlay;
         this.FUISpecReward.OnOut = this.PerformOnOut;
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Award"],true);
         this.FMC_Scene["BTN_Award"].addEventListener(MouseEvent.CLICK,this.OnBtnAward);
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_SpecAward"],true);
         this.FMC_Scene["BTN_SpecAward"].addEventListener(MouseEvent.CLICK,this.OnBtnSpecAward);
         if(this.FEffectGlow == null)
         {
            this.FEffectGlow = new TEffectBaseGlow();
            this.FEffectGlow.SetParameters(this.FMC_Scene["BTN_Award"],15911245,1);
         }
      }
      
      public function SetDate(param1:TTalentGifts) : void
      {
         this.FTalentGifts = param1;
         if(this.FTalentGifts)
         {
            this.FUIReward.UpdateUI(this.FTalentGifts.RewardList);
            this.FUISpecReward.UpdateUI(this.FTalentGifts.TopRewardList);
            this.FMC_Scene["TF_Level"].text = this.FTalentGifts.RefreshTalentGifts.Count;
            this.FEffectGlow && this.FEffectGlow.Stop();
            if(this.FTalentGifts.Reward == 1)
            {
               this.FMC_Scene["MC_Got"].visible = true;
            }
            else
            {
               this.FMC_Scene["MC_Got"].visible = false;
               if(this.FTalentGifts.Reward == 0)
               {
                  this.FEffectGlow && this.FEffectGlow.Run();
               }
            }
            if(this.FTalentGifts.TopReward == 0)
            {
               TGameUtil.setButtonMode(this.FMC_Scene["BTN_SpecAward"],true);
               this.FMC_Scene["BTN_SpecAward"].mouseEnabled = true;
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_Scene["BTN_SpecAward"],false);
               this.FMC_Scene["BTN_SpecAward"].mouseEnabled = false;
            }
            TGameUtil.ChangeBtnContent(this.FMC_Scene["BTN_SpecAward"],this.FTalentGifts.TopReward == 1 ? STRING_BASEACTIVITY.FORMAT_BTN_STRING_1 : STRING_TONGLING.TONGLING_LINGQU);
         }
      }
      
      public function get TalentGifts() : TTalentGifts
      {
         return this.FTalentGifts;
      }
      
      public function LogicsPerform() : void
      {
         this.FUIReward.LogicsPerform();
         this.FUISpecReward.LogicsPerform();
         if(this.FEffectGlow != null && this.FEffectGlow.IsRunOver)
         {
            this.FEffectGlow.Run();
         }
      }
      
      protected function OnBtnAward(param1:MouseEvent) : void
      {
         if(this.OnRewardTalentGift != null && this.FTalentGifts != null)
         {
            this.OnRewardTalentGift(this.FTalentGifts.Identifier,GIFTS_NORMAL);
         }
      }
      
      protected function OnBtnSpecAward(param1:MouseEvent) : void
      {
         if(this.OnRewardTalentGift != null && this.FTalentGifts != null)
         {
            this.OnRewardTalentGift(this.FTalentGifts.Identifier,GIFTS_TOPUP);
         }
      }
      
      protected function PerformOnOverlay(param1:Object, param2:Object) : void
      {
         if(this.OnHintOver != null)
         {
            this.OnHintOver(param1,param2);
         }
      }
      
      protected function PerformOnOut(param1:Object, param2:Object) : void
      {
         if(this.OnHintOut != null)
         {
            this.OnHintOut(param1,param2);
         }
      }
   }
}

