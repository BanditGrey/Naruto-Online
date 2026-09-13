package Processors.Game.Lobby.Undertown.LittlePanel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TDungeonsBattle;
   import Logics.DatebaseVO.VO.TDungeonsBattleConfig;
   import Logics.Undertown.TUndertownLogicData;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Lobby.Undertown.CellPanel.*;
   import Resources.Strings.STRING_UNDERTOWN;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class LittleTwoPanel extends Sprite
   {
      
      public static const THREE:int = 3;
      
      public static const Ten:int = 10;
      
      protected var FParent:TUIComponent;
      
      protected var FTempPanel:MovieClip;
      
      protected var FTF_HighestLayer:TextField;
      
      protected var FTF_CurLayer:TextField;
      
      protected var FMC_GoInChallenge:MovieClip;
      
      protected var FMC_BackBtn:MovieClip;
      
      protected var FMC_UpBtn:MovieClip;
      
      protected var FMC_DownBtn:MovieClip;
      
      protected var FMC_0:MovieClip;
      
      protected var FMC_1:MovieClip;
      
      protected var FLittleCellVector:Vector.<LittleCell>;
      
      protected var FChallengeBtnBackFunction:Function;
      
      protected var FBackBtnFunction:Function;
      
      protected var FLogicData:TUndertownLogicData = null;
      
      protected var FCurStartCusToms:TDungeonsBattleConfig;
      
      protected var FCurCusTomsData:Vector.<TDungeonsBattle>;
      
      protected var FCurIndex:int;
      
      protected var FCurFream:int;
      
      protected var FreamVector:Vector.<uint>;
      
      public function LittleTwoPanel(param1:TUIComponent)
      {
         super();
         this.FCurCusTomsData = new Vector.<TDungeonsBattle>();
         this.FLittleCellVector = new Vector.<LittleCell>(Ten);
         this.FParent = param1;
         this.FreamVector = new Vector.<uint>();
         this.FreamVector.push(1);
         this.FreamVector.push(17);
         this.FreamVector.push(24);
         this.FreamVector.push(29);
         this.FreamVector.push(33);
         this.FreamVector.push(37);
         this.FreamVector.push(41);
         this.FreamVector.push(44);
      }
      
      public function set TempPanel(param1:MovieClip) : void
      {
         this.FTempPanel = param1;
         addChild(this.FTempPanel);
         this.UIDispatch();
      }
      
      protected function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:LittleCell = null;
         this.FTF_HighestLayer = this.FTempPanel["TF_HighestLayer"];
         this.FTF_CurLayer = this.FTempPanel["TF_CurLayer"];
         this.FMC_GoInChallenge = this.FTempPanel["MC_GoInChallenge"];
         this.FMC_BackBtn = this.FTempPanel["MC_BackBtn"];
         this.FMC_GoInChallenge.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_BackBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         TGameUtil.setButtonMode(this.FMC_BackBtn,true);
         this.FMC_UpBtn = this.FTempPanel["MC_UpBtn"];
         this.FMC_DownBtn = this.FTempPanel["MC_DownBtn"];
         this.FMC_UpBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_DownBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_0 = this.FTempPanel["MC_0"];
         _loc1_ = 0;
         while(_loc1_ < Ten)
         {
            _loc2_ = new LittleCell(this.FMC_0["MC_0"]["MC_CustomsCell_" + _loc1_],_loc1_);
            this.FLittleCellVector[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(!this.FTempPanel)
         {
            return;
         }
         if(!this.visible)
         {
            return;
         }
         if(!this.FMC_0)
         {
            return;
         }
         _loc1_ = uint(this.FMC_0.currentFrame);
         if(this.FCurFream == _loc1_)
         {
            return;
         }
         if(this.FCurFream > _loc1_)
         {
            _loc1_ += 1;
            this.FMC_0.gotoAndStop(_loc1_);
         }
         if(this.FCurFream < _loc1_)
         {
            _loc1_--;
            this.FMC_0.gotoAndStop(_loc1_);
         }
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_GoInChallenge:
               if(!this.FMC_GoInChallenge.buttonMode)
               {
                  return;
               }
               if(!this.FLogicData.CurCustomsData)
               {
                  return;
               }
               if(this.FLogicData.CurCustomsData.Identifier > this.FCurCusTomsData[this.FCurCusTomsData.length - 1].Identifier)
               {
                  return;
               }
               if(this.FChallengeBtnBackFunction != null)
               {
                  this.FChallengeBtnBackFunction();
               }
               break;
            case this.FMC_BackBtn:
               if(!this.FMC_BackBtn.buttonMode)
               {
                  return;
               }
               if(this.FBackBtnFunction != null)
               {
                  this.FBackBtnFunction();
               }
               break;
            case this.FMC_UpBtn:
               --this.FCurIndex;
               this.Checkindex();
               this.UpdateCusTomsThree();
               break;
            case this.FMC_DownBtn:
               ++this.FCurIndex;
               this.Checkindex();
               this.UpdateCusTomsThree();
         }
      }
      
      protected function IsThisUpdate() : void
      {
      }
      
      protected function UpdateCusTomsThree() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < Ten)
         {
            this.FLittleCellVector[_loc1_].CurData = this.FCurCusTomsData[_loc1_];
            this.FLittleCellVector[_loc1_].UpdateView();
            _loc1_++;
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:String = null;
         _loc1_ = this.FLogicData.TheHighestCustomsClearanceRecord;
         this.FTF_HighestLayer.text = _loc1_;
         if(!this.FLogicData.LastCustomsData)
         {
            _loc1_ = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_3).DescribeString;
         }
         else
         {
            _loc1_ = this.FLogicData.LastCustomsData.Name;
         }
         this.FTF_CurLayer.text = _loc1_;
         this.Niemi();
         this.UpdateCusTomsThree();
         if(!this.FLogicData.CurCustomsData || this.FLogicData.CurCustomsData.Identifier >= this.FCurStartCusToms.StageStartId + this.FCurStartCusToms.CampaignCount)
         {
            TGameUtil.setButtonMode(this.FMC_GoInChallenge,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_GoInChallenge,true);
         }
      }
      
      public function set ChallengeBtnBackFunction(param1:Function) : void
      {
         this.FChallengeBtnBackFunction = param1;
      }
      
      public function set BackBtnFunction(param1:Function) : void
      {
         this.FBackBtnFunction = param1;
      }
      
      public function set StartCustomsData(param1:TDungeonsBattleConfig) : void
      {
         var _loc2_:TDungeonsBattle = null;
         var _loc3_:uint = 0;
         if(!this.FCurStartCusToms)
         {
            this.FCurStartCusToms = param1;
            this.FCurCusTomsData.length = 0;
            _loc3_ = 0;
            while(_loc3_ < this.FCurStartCusToms.CampaignCount)
            {
               _loc2_ = this.FLogicData.DungeonsBattleBin.GetDatebaseByIdentifier(this.FCurStartCusToms.StageStartId + _loc3_) as TDungeonsBattle;
               this.FCurCusTomsData.push(_loc2_);
               _loc3_++;
            }
         }
         else
         {
            if(param1.Identifier != this.FCurStartCusToms.Identifier)
            {
               this.FCurCusTomsData.length = 0;
               _loc3_ = 0;
               while(_loc3_ < param1.CampaignCount)
               {
                  _loc2_ = this.FLogicData.DungeonsBattleBin.GetDatebaseByIdentifier(param1.StageStartId + _loc3_) as TDungeonsBattle;
                  this.FCurCusTomsData.push(_loc2_);
                  _loc3_++;
               }
            }
            this.FCurStartCusToms = param1;
         }
      }
      
      protected function Niemi() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FCurStartCusToms.StageStartId + this.FCurStartCusToms.CampaignCount - 1;
         if(!this.FLogicData.CurCustomsData)
         {
            this.FCurIndex = 0;
         }
         else if(this.FLogicData.CurCustomsData.Identifier > _loc1_)
         {
            this.FCurIndex = 0;
         }
         else
         {
            this.FCurIndex = this.FLogicData.CurCustomsData.Identifier - this.FCurStartCusToms.StageStartId;
         }
         this.Checkindex();
      }
      
      public function set LogicData(param1:TUndertownLogicData) : void
      {
         this.FLogicData = param1;
      }
      
      protected function Checkindex() : void
      {
         TGameUtil.setButtonMode(this.FMC_UpBtn,true);
         TGameUtil.setButtonMode(this.FMC_DownBtn,true);
         if(this.FCurIndex <= 0)
         {
            this.FCurIndex = 0;
            TGameUtil.setButtonMode(this.FMC_UpBtn,false);
         }
         if(this.FCurIndex >= 7)
         {
            this.FCurIndex = 7;
            TGameUtil.setButtonMode(this.FMC_DownBtn,false);
         }
         this.FCurFream = this.FreamVector[this.FCurIndex];
      }
   }
}

