package Processors.Game.Lobby.Undertown.CellPanel
{
   import Foundation.Timing.STimingCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.Undertown.TUndertownPracticeListData;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Strings.STRING_UNDERTOWN;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class PracticeListCell
   {
      
      protected var FMainUI:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_State:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FMC_Describe:MovieClip;
      
      protected var FTF_TimeDesCribe:TextField;
      
      protected var FMC_OccupyBtn:MovieClip;
      
      protected var FTF_Dec:TextField;
      
      protected var FPracticeListData:TUndertownPracticeListData;
      
      protected var FCurState:int;
      
      protected var FGetRewardBtnBackFunction:Function;
      
      protected var FOccupyBtnOnOver:Function;
      
      protected var FOccupyBtnOnOut:Function;
      
      public function PracticeListCell()
      {
         super();
      }
      
      public function UpdateView() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc1_:String = "";
         var _loc2_:String = "";
         _loc6_ = uint(SLogicsCore.Character.MainHero.Level);
         _loc3_ = uint(this.FPracticeListData.DungeonsPractiseData.LevelRangeArr[0]);
         _loc4_ = uint(this.FPracticeListData.DungeonsPractiseData.LevelRangeArr[1]);
         _loc1_ = this.FPracticeListData.DungeonsPractiseData.CampaignName;
         this.FTF_Name.text = _loc1_;
         if(_loc3_ > 1000)
         {
            _loc1_ = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(_loc3_);
         }
         else
         {
            _loc1_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_14).DescribeString,_loc3_);
         }
         if(_loc4_ > 1000)
         {
            _loc2_ = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(_loc4_);
         }
         else
         {
            _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_14).DescribeString,_loc4_);
         }
         this.FTF_Level.text = _loc1_;
         if(SLogicsCore.UndertownLogicData.HistoricHighsCustomsData)
         {
            _loc5_ = uint(SLogicsCore.UndertownLogicData.HistoricHighsCustomsData.Identifier);
         }
         else
         {
            _loc5_ = 0;
         }
         if(this.FPracticeListData.DungeonsPractiseData.NeedStageId > _loc5_)
         {
            this.FMC_OccupyBtn.visible = false;
            this.FTF_State.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_21).DescribeString;
            this.FMC_Describe.visible = false;
            this.FPracticeListData.Rest();
         }
         else
         {
            this.FMC_OccupyBtn.visible = true;
            if(_loc6_ < _loc3_ || _loc6_ > _loc4_)
            {
            }
            if(this.FPracticeListData.Identifier0 == 0 && this.FPracticeListData.Identifier1 == 0)
            {
               if(this.FPracticeListData.DungeonsPractiseData.NeedStageId > _loc5_)
               {
                  this.FTF_State.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_21).DescribeString;
               }
               else
               {
                  this.FTF_State.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_22).DescribeString;
               }
               this.FTF_Dec.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_23).DescribeString;
               this.FMC_Describe.visible = false;
               this.FCurState = 0;
               this.FTF_Time.text = "";
            }
            else
            {
               this.FTF_State.text = this.FPracticeListData.UserName;
               if(this.FPracticeListData.Identifier0 == SLogicsCore.Character.Identifier0 && this.FPracticeListData.Identifier1 == SLogicsCore.Character.Identifier1)
               {
                  this.FTF_Dec.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_24).DescribeString;
                  this.FMC_Describe.visible = false;
                  this.FCurState = 1;
               }
               else
               {
                  this.FTF_Dec.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_25).DescribeString;
                  _loc8_ = this.FPracticeListData.FirstOccupyProtectEndTime;
                  _loc9_ = this.FPracticeListData.AttackedProtectEndTime;
                  _loc7_ = _loc8_ > _loc9_ ? _loc8_ : _loc9_;
                  if(_loc7_ > STimingCore.GetServerTick())
                  {
                     this.FMC_OccupyBtn.visible = false;
                     this.FMC_Describe.visible = true;
                  }
                  else
                  {
                     this.FMC_Describe.visible = false;
                  }
                  this.FCurState = 2;
               }
            }
         }
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(!this.FMainUI.visible)
         {
            return;
         }
         if(this.FPracticeListData.PracticeEndTime > STimingCore.GetServerTick())
         {
            _loc1_ = this.FPracticeListData.PracticeEndTime - STimingCore.GetServerTick();
         }
         else
         {
            _loc1_ = 0;
         }
         this.FTF_Time.text = TGameUtil.fomatTime(_loc1_);
         _loc2_ = this.FPracticeListData.FirstOccupyProtectEndTime;
         _loc3_ = this.FPracticeListData.AttackedProtectEndTime;
         _loc1_ = _loc2_ > _loc3_ ? _loc2_ : _loc3_;
         if(this.FMC_Describe.visible)
         {
            this.FTF_TimeDesCribe.text = TGameUtil.fomatTime(_loc1_ - STimingCore.GetServerTick());
            if(_loc1_ <= STimingCore.GetServerTick())
            {
               _loc2_ = 777;
               this.FMC_Describe.visible = false;
            }
         }
         if(_loc2_ == 777)
         {
            this.UpdateView();
         }
      }
      
      protected function BackFunction(param1:MouseEvent) : void
      {
         if(this.FGetRewardBtnBackFunction != null)
         {
            this.FGetRewardBtnBackFunction(this.FPracticeListData.DungeonsPractiseData.Identifier,this.FCurState);
         }
      }
      
      protected function ProcessorOccupyBtnOnOver(param1:MouseEvent) : void
      {
         if(this.FOccupyBtnOnOver != null)
         {
            this.FOccupyBtnOnOver(this.FPracticeListData.DungeonsPractiseData.DropDesc);
         }
      }
      
      protected function ProcessorOccupyBtnOnOut(param1:MouseEvent) : void
      {
         if(this.FOccupyBtnOnOut != null)
         {
            this.FOccupyBtnOnOut();
         }
      }
      
      public function set PracticeListData(param1:TUndertownPracticeListData) : void
      {
         this.FPracticeListData = param1;
      }
      
      public function set GetRewardBtnBackFunction(param1:Function) : void
      {
         this.FGetRewardBtnBackFunction = param1;
      }
      
      public function get OccupyBtnOnOver() : Function
      {
         return this.FOccupyBtnOnOver;
      }
      
      public function set OccupyBtnOnOver(param1:Function) : void
      {
         this.FOccupyBtnOnOver = param1;
      }
      
      public function get OccupyBtnOnOut() : Function
      {
         return this.FOccupyBtnOnOut;
      }
      
      public function set OccupyBtnOnOut(param1:Function) : void
      {
         this.FOccupyBtnOnOut = param1;
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
      
      public function get CurState() : int
      {
         return this.FCurState;
      }
      
      protected function Inilization() : void
      {
         this.FTF_Name = this.FMainUI["TF_Name"];
         this.FTF_Level = this.FMainUI["TF_Level"];
         this.FTF_State = this.FMainUI["TF_State"];
         this.FTF_Time = this.FMainUI["TF_Time"];
         this.FMC_Describe = this.FMainUI["MC_Describe"];
         this.FTF_TimeDesCribe = this.FMC_Describe["TF_TimeDesCribe"];
         this.FMC_OccupyBtn = this.FMainUI["MC_OccupyBtn"];
         TGameUtil.setButtonMode(this.FMC_OccupyBtn,true);
         this.FMC_OccupyBtn.addEventListener(MouseEvent.CLICK,this.BackFunction);
         this.FMC_OccupyBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOccupyBtnOnOver);
         this.FMC_OccupyBtn.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOccupyBtnOnOut);
         this.FTF_Dec = this.FMC_OccupyBtn["TF_Dec"];
      }
   }
}

