package Processors.Game.Lobby.TopOrganization.Componets
{
   import Foundation.UI.TUIComponent;
   import Logics.TopOrganization.TSequenceRanking;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.text.TextField;
   
   public class TUIWinStreak extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Ranking:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Organization:TextField;
      
      protected var FTF_Win:TextField;
      
      protected var FTF_Reward:TextField;
      
      public function TUIWinStreak(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_Ranking = FResource["TF_Ranking"];
         this.FTF_Name = FResource["TF_Name"];
         this.FTF_Organization = FResource["TF_Organization"];
         this.FTF_Win = FResource["TF_Win"];
         this.FTF_Reward = FResource["TF_Reward"];
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TSequenceRanking = null;
         if(FContext == null)
         {
            return;
         }
         if(FContext is TSequenceRanking)
         {
            _loc1_ = FContext as TSequenceRanking;
            this.FTF_Ranking.text = _loc1_.Rank.toString();
            this.FTF_Name.text = _loc1_.PlayerName;
            this.FTF_Organization.text = _loc1_.OrgName;
            this.FTF_Win.text = _loc1_.SequenceCount.toString();
            this.FTF_Reward.text = _loc1_.RewardSilverCoin / 10000 + STRING_TOPORGANIZATION.STRING_SilverCoin;
         }
      }
   }
}

