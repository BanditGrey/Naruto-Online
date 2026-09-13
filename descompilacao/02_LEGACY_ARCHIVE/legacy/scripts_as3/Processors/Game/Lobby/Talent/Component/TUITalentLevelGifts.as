package Processors.Game.Lobby.Talent.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.LevelGifts.TLevelGifts;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUITalentLevelGifts extends TUIComponent
   {
      
      protected static const GIFTS_NORMAL:int = 1;
      
      protected static const GIFTS_TOPUP:int = 2;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUIReward:TUIBaseBox;
      
      protected var FUISpecReward:TUIBaseBox;
      
      protected var FLevelGifts:TLevelGifts;
      
      protected var FEffectGlow:TEffectBaseGlow;
      
      public var OnRewardLevelGift:Function;
      
      public var OnHintOver:Function;
      
      public var OnHintOut:Function;
      
      public function TUITalentLevelGifts(param1:TUIComponent)
      {
         super(param1);
         this.UIResourceDispatch();
      }
      
      protected function UIResourceDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("box_talentLevelGifts") as MovieClip;
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
      
      public function SetDate(param1:TLevelGifts) : void
      {
         this.FLevelGifts = param1;
         if(this.FLevelGifts)
         {
            this.FUIReward.UpdateUI(this.FLevelGifts.RewardList);
            this.FUISpecReward.UpdateUI(this.FLevelGifts.TopRewardList);
            this.FMC_Scene["TF_Level"].text = this.FLevelGifts.TalentLevelGifts.Level;
            this.FEffectGlow && this.FEffectGlow.Stop();
            if(this.FLevelGifts.Reward == 1)
            {
               this.FMC_Scene["MC_Got"].visible = true;
            }
            else
            {
               this.FMC_Scene["MC_Got"].visible = false;
               if(this.FLevelGifts.Reward == 0)
               {
                  this.FEffectGlow && this.FEffectGlow.Run();
               }
            }
            if(this.FLevelGifts.TopReward == 0)
            {
               TGameUtil.setButtonMode(this.FMC_Scene["BTN_SpecAward"],true);
               this.FMC_Scene["BTN_SpecAward"].mouseEnabled = true;
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_Scene["BTN_SpecAward"],false);
               this.FMC_Scene["BTN_SpecAward"].mouseEnabled = false;
            }
            TGameUtil.ChangeBtnContent(this.FMC_Scene["BTN_SpecAward"],this.FLevelGifts.TopReward == 1 ? STRING_BASEACTIVITY.FORMAT_BTN_STRING_1 : STRING_TONGLING.TONGLING_LINGQU);
         }
      }
      
      public function get LevelGifts() : TLevelGifts
      {
         return this.FLevelGifts;
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
         if(this.OnRewardLevelGift != null && this.FLevelGifts != null)
         {
            this.OnRewardLevelGift(this.FLevelGifts.Identifier,GIFTS_NORMAL);
         }
      }
      
      protected function OnBtnSpecAward(param1:MouseEvent) : void
      {
         if(this.OnRewardLevelGift != null && this.FLevelGifts != null)
         {
            this.OnRewardLevelGift(this.FLevelGifts.Identifier,GIFTS_TOPUP);
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

