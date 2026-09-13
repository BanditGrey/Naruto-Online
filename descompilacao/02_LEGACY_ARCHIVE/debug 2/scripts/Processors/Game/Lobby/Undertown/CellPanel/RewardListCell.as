package Processors.Game.Lobby.Undertown.CellPanel
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.Undertown.TDailyTaskRewardCopy;
   import Logics.Undertown.TUndertownRewardListData;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_UNDERTOWN;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class RewardListCell
   {
      
      protected var FMainUI:MovieClip;
      
      protected var FRewardListData:TUndertownRewardListData;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Value_Name:TextField;
      
      protected var FTF_Reward:TextField;
      
      protected var FTF_Value_Reward:TextField;
      
      protected var FMC_GetrewardBtn:MovieClip;
      
      protected var FBackFunction:Function;
      
      public function RewardListCell()
      {
         super();
      }
      
      protected function Inilization() : void
      {
         this.FTF_Name = this.FMainUI["TF_Name"];
         this.FTF_Value_Name = this.FMainUI["TF_Value_Name"];
         this.FTF_Reward = this.FMainUI["TF_Reward"];
         this.FTF_Value_Reward = this.FMainUI["TF_Value_Reward"];
         this.FMC_GetrewardBtn = this.FMainUI["MC_GetrewardBtn"];
         TGameUtil.setButtonMode(this.FMC_GetrewardBtn,true);
         this.FMC_GetrewardBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      public function UpdateView() : void
      {
         var _loc2_:TArticle = null;
         var _loc3_:int = 0;
         var _loc4_:TDailyTaskRewardCopy = null;
         var _loc5_:uint = 0;
         var _loc1_:String = "";
         var _loc6_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc3_ = 0;
         while(_loc3_ < this.FRewardListData.AwardVect.length)
         {
            _loc4_ = this.FRewardListData.AwardVect[_loc3_];
            _loc5_ = CONST_COMMON.GetItemIDByType(_loc4_.Type,_loc4_.Code,_loc6_);
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_) as TArticle;
            _loc1_ += _loc2_.Name + " *" + _loc4_.Amount;
            _loc3_++;
         }
         if(this.FRewardListData.Type == 1)
         {
            this.FTF_Name.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_17).DescribeString;
            this.FTF_Value_Name.text = TGameUtil.fomatTime(this.FRewardListData.AllPracticeTime);
            this.FTF_Reward.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_18).DescribeString;
         }
         else
         {
            this.FTF_Name.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_19).DescribeString;
            this.FTF_Value_Name.text = this.FRewardListData.Name;
            this.FTF_Reward.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_20).DescribeString;
         }
         this.FTF_Value_Reward.text = _loc1_;
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         if(this.FBackFunction != null)
         {
            this.FBackFunction(this.FRewardListData.DiaoLuoTime);
         }
      }
      
      public function set MainUI(param1:MovieClip) : void
      {
         this.FMainUI = param1;
         this.Inilization();
      }
      
      public function get MainUI() : MovieClip
      {
         return this.FMainUI;
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      public function set RewardListData(param1:TUndertownRewardListData) : void
      {
         this.FRewardListData = param1;
      }
   }
}

