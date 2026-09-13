package Processors.Game.Lobby.TopOrganization.Componets
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TGVG3BetOrg;
   import Logics.TopOrganization.TTopOrganizationData;
   import Logics.TopOrganization.TUserBetInfo;
   import Logics.TopOrganization.TUserBetInfos;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIOrgBet extends TProcessorUIResourceTemplate
   {
      
      protected const CAPACITY_BETS:uint = 3;
      
      protected var FTF_OrgName:TextField;
      
      protected var FTF_OrgLevel:TextField;
      
      protected var FTF_Population:TextField;
      
      protected var FTF_BetGoldCoin:TextField;
      
      protected var FMC_BetInfo:Sprite;
      
      protected var FMC_HasBet:MovieClip;
      
      protected var FTF_HasBet:TextField;
      
      protected var FMC_Bets:Vector.<MovieClip>;
      
      protected var FInitialized:Boolean;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FBetOnClick:Function;
      
      public function TUIOrgBet(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Bets = new Vector.<MovieClip>(this.CAPACITY_BETS);
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
      }
      
      override protected function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         if(FResource == null)
         {
            return;
         }
         this.FTF_OrgName = FResource["TF_OrgName"];
         this.FTF_OrgLevel = FResource["TF_OrgLevel"];
         this.FTF_Population = FResource["TF_Population"];
         this.FTF_BetGoldCoin = FResource["TF_BetGoldCoin"];
         this.FMC_BetInfo = FResource["MC_BetInfo"];
         this.FMC_BetInfo.visible = false;
         this.FMC_HasBet = FResource["MC_HasBet"];
         this.FMC_HasBet.visible = false;
         this.FTF_HasBet = this.FMC_HasBet["TF_HasBet"];
         _loc2_ = this.CAPACITY_BETS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_BetInfo["MC_Bet_" + _loc1_];
            TGameUtil.setButtonMode(_loc3_,true);
            this.FMC_Bets[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FInitialized = true;
      }
      
      override protected function UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         if(!this.FInitialized)
         {
            return;
         }
         _loc2_ = this.CAPACITY_BETS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Bets[_loc1_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.MCBetOnClick,false,0,true);
            _loc1_++;
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TGVG3BetOrg = null;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUserBetInfo = null;
         var _loc6_:TUserBetInfos = null;
         this.Reset();
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TGVG3BetOrg;
         _loc6_ = this.FTopOrganizationData.UserBetInfos;
         this.FTF_OrgName.text = _loc1_.OrgName;
         this.FTF_OrgLevel.text = _loc1_.OrgLevel.toString();
         this.FTF_Population.text = _loc1_.OrgMembersCount.toString();
         this.FTF_BetGoldCoin.text = _loc1_.TotalBetCount + "W";
         _loc3_ = this.FTopOrganizationData.CurrentRound;
         _loc5_ = _loc6_.GetUserBetInfoByIndex(_loc6_.Count - 1);
         _loc4_ = this.FTopOrganizationData.CurrentBetCircle;
         if(_loc4_ > 0)
         {
            _loc2_ = this.FTopOrganizationData.BetOrg == Tag;
            if(_loc2_)
            {
               this.FTF_HasBet.text = TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_HasBet,STRING_TOPORGANIZATION.STRING_BetType[this.FTopOrganizationData.BetType - 1]);
               this.FMC_BetInfo.visible = !_loc2_;
            }
            this.FMC_HasBet.visible = _loc2_;
         }
         else
         {
            this.FMC_BetInfo.visible = true;
            this.FMC_HasBet.visible = false;
         }
      }
      
      protected function MCBetOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc3_ = param1.currentTarget.name;
         _loc2_ = int(_loc3_.split("_")[2]);
         if(this.FBetOnClick != null)
         {
            this.FBetOnClick(this,FContext,_loc2_ + 1);
         }
      }
      
      public function set BetOnClick(param1:Function) : void
      {
         this.FBetOnClick = param1;
      }
      
      override public function Reset() : void
      {
         if(this.FInitialized)
         {
            this.FTF_OrgName.text = "";
            this.FTF_OrgLevel.text = "";
            this.FTF_Population.text = "";
            this.FTF_BetGoldCoin.text = "";
            this.FTF_HasBet.text = "";
            this.FMC_HasBet.visible = false;
            this.FMC_BetInfo.visible = false;
         }
      }
   }
}

