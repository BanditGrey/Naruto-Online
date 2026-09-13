package Processors.Game.Lobby.TheWorldTree.LittlePanel
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_THEWORLDTREE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowDuoTasking_ChangeType extends TProcessorLobbyWindow
   {
      
      public static const Three:int = 3;
      
      protected var FThisPanel:Sprite;
      
      protected var FMC_CloseBtn:SimpleButton;
      
      protected var FMC_HelpBtn:SimpleButton;
      
      protected var FCampaignVec:Vector.<MovieClip>;
      
      protected var FTF_HaveDuoTaskingTicket:TextField;
      
      protected var FMC_BeginFight:SimpleButton = null;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var FCurIndex:int;
      
      protected var FBackFun:Function;
      
      protected var FBackOverFun:Function;
      
      protected var FBackOutFun:Function;
      
      public function TProcessorWindowDuoTasking_ChangeType(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FCampaignVec = new Vector.<MovieClip>(Three);
         this.FLogicDate = SLogicsCore.TheWorldTreeLogicData;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("DuoTasking_ChangeType") as Sprite;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_CloseBtn = this.FThisPanel["MC_CloseBtn"];
         this.FMC_HelpBtn = this.FThisPanel["MC_HelpBtn"];
         this.FMC_BeginFight = this.FThisPanel["MC_BeginFight"];
         this.FTF_HaveDuoTaskingTicket = this.FThisPanel["TF_HaveDuoTaskingTicket"];
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            this.FCampaignVec[_loc1_] = this.FThisPanel["MC_Campaign_" + _loc1_];
            this.FCampaignVec[_loc1_].buttonMode = true;
            _loc2_ = this.FCampaignVec[_loc1_]["MC_bg"];
            _loc2_.gotoAndStop(_loc1_ + 1);
            _loc2_ = this.FCampaignVec[_loc1_]["MC_Label"];
            _loc2_.mouseEnabled = false;
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:Vector.<uint> = null;
         this.FMC_BeginFight.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FMC_CloseBtn.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FMC_HelpBtn.addEventListener(MouseEvent.MOUSE_OVER,this.HandleOver);
         this.FMC_HelpBtn.addEventListener(MouseEvent.ROLL_OUT,this.HandleOut);
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            this.FCampaignVec[_loc1_].addEventListener(MouseEvent.CLICK,this.CloseClick);
            _loc2_ = this.FCampaignVec[_loc1_]["TF_Name"];
            _loc2_.text = new ConsumeFrameCopy(STRING_THEWORLDTREE.str29[_loc1_]).DescribeString;
            _loc2_ = this.FCampaignVec[_loc1_]["TF_MaxMoney"];
            switch(_loc1_)
            {
               case 0:
                  _loc3_ = this.FLogicDate.ChuJiRewardVec;
                  break;
               case 1:
                  _loc3_ = this.FLogicDate.GaoJiRewardVec;
                  break;
               case 2:
                  _loc3_ = this.FLogicDate.DingJiRewardVec;
            }
            _loc2_.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str30).DescribeString,_loc3_[_loc3_.length - 1]);
            _loc2_ = this.FCampaignVec[_loc1_]["TF_Consume_dollMoney"];
            _loc2_.text = this.FLogicDate.RiskThreeDifficultyCost[_loc1_].toString();
            _loc1_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function CloseClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_CloseBtn:
               this.visible = false;
               break;
            case this.FCampaignVec[0]:
               this.FCurIndex = 0;
               this.UpdateSatteByIndex();
               break;
            case this.FCampaignVec[1]:
               this.FCurIndex = 1;
               this.UpdateSatteByIndex();
               break;
            case this.FCampaignVec[2]:
               this.FCurIndex = 2;
               this.UpdateSatteByIndex();
               break;
            case this.FMC_BeginFight:
               if(this.FBackFun != null)
               {
                  this.FBackFun(this.FCurIndex + 1);
               }
         }
      }
      
      protected function HandleOver(param1:MouseEvent) : void
      {
         var _loc3_:TSystemLanguage = null;
         var _loc2_:THint = new THint();
         if(this.FBackOverFun != null)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70300003) as TSystemLanguage;
            _loc2_.Content = _loc3_.Desc;
            this.FBackOverFun(this,_loc2_);
         }
      }
      
      protected function HandleOut(param1:MouseEvent) : void
      {
         if(this.FBackOutFun != null)
         {
            this.FBackOutFun();
         }
      }
      
      protected function UpdateSatteByIndex() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            this.FCampaignVec[_loc1_].addEventListener(MouseEvent.CLICK,this.CloseClick);
            _loc2_ = this.FCampaignVec[_loc1_]["MC_Label"];
            _loc2_.visible = false;
            _loc1_++;
         }
         _loc2_ = this.FCampaignVec[this.FCurIndex]["MC_Label"];
         _loc2_.visible = true;
      }
      
      public function UpdateFreeCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         this.UpdateSatteByIndex();
         this.FTF_HaveDuoTaskingTicket.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str32).DescribeString,this.FLogicDate.MaoXianYouXiQuanName,this.FLogicDate.WanOuYouXiQuanCount);
         _loc2_ = this.FCampaignVec[0]["TF_TodayFreeCount"];
         _loc1_ = this.FLogicDate.EverydayRiskCount[0] - this.FLogicDate.ModeCountOne;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         _loc2_.text = _loc1_.toString();
         _loc2_ = this.FCampaignVec[1]["TF_TodayFreeCount"];
         _loc1_ = this.FLogicDate.EverydayRiskCount[1] - this.FLogicDate.ModeCountTwo;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         _loc2_.text = _loc1_.toString();
         _loc2_ = this.FCampaignVec[2]["TF_TodayFreeCount"];
         _loc1_ = this.FLogicDate.EverydayRiskCount[2] - this.FLogicDate.ModeCountThree;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         _loc2_.text = _loc1_.toString();
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function set BackOverFun(param1:Function) : void
      {
         this.FBackOverFun = param1;
      }
      
      public function set BackOutFun(param1:Function) : void
      {
         this.FBackOutFun = param1;
      }
      
      public function get MC_Close() : SimpleButton
      {
         return this.FMC_HelpBtn;
      }
   }
}

