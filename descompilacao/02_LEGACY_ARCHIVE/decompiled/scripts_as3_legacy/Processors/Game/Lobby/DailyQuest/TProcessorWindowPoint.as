package Processors.Game.Lobby.DailyQuest
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Dailytask.TDailytask;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TDailyAward;
   import Logics.DatebaseVO.VO.TDailyTask;
   import Logics.Inventories.TAppliance;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.DailyQuest.Component.TUIRewardList;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DAILY_QUEST;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import ghostcat.operation.RepeatOper;
   import ghostcat.operation.TweenOper;
   import ghostcat.util.easing.Cubic;
   
   public class TProcessorWindowPoint extends TProcessorLobbyWindow
   {
      
      protected static const REWARD_LISTS:uint = 10;
      
      protected static const TOTAL_POINT:uint = 165;
      
      protected static const OFFSET:uint = 5;
      
      protected static const GRADE:uint = 15;
      
      protected static const DOUBLE_TYPE:uint = 18;
      
      protected var FRepeatOperExpBar:RepeatOper;
      
      protected var FRepeatOperFloatingBar:RepeatOper;
      
      protected var FTweenOperInExpBar:TweenOper;
      
      protected var FTweenOperOutExpBar:TweenOper;
      
      protected var FTweenOperInFloatingBar:TweenOper;
      
      protected var FTweenOperOutFloatingBar:TweenOper;
      
      protected var FMC_Point:Sprite;
      
      protected var FDoubleSlot:Sprite;
      
      protected var FMC_ExpBar:Sprite;
      
      protected var FMC_YellowBar:Sprite;
      
      protected var FMC_CurrentPoint:Sprite;
      
      protected var FMC_BmpIcon:Sprite;
      
      protected var FMC_FinishTag:Sprite;
      
      protected var FTF_CurrentPoint:TextField;
      
      protected var FMC_GainRewardBT:MovieClip;
      
      protected var FMC_RewardLists:Vector.<TUIRewardList>;
      
      protected var FBitmap:Bitmap;
      
      protected var FIndex:int;
      
      protected var FDailyTaskBin:TBins;
      
      protected var FDailyAwardBin:TBins;
      
      protected var FDailytask:TDailytask;
      
      protected var FCharacter:TCharacter;
      
      protected var FAwardIndex:uint;
      
      protected var FAppliances:Vector.<TAppliance>;
      
      protected var FCurrentPoint:uint;
      
      protected var FArticleBins:TBins;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      protected var FPoint:uint;
      
      protected var FListRewardOnOver:Function;
      
      protected var FListRewardOnOut:Function;
      
      public function TProcessorWindowPoint(param1:TUIComponent)
      {
         super(param1);
         this.ConstructTweens();
         this.FMC_RewardLists = new Vector.<TUIRewardList>(REWARD_LISTS);
         this.FAppliances = new Vector.<TAppliance>();
         this.FDailytask = SLogicsCore.Character.DailyTask;
         this.FCharacter = SLogicsCore.Character;
      }
      
      protected function ConstructTweens() : void
      {
         this.FRepeatOperExpBar = new RepeatOper();
         this.FRepeatOperFloatingBar = new RepeatOper();
         this.FTweenOperInExpBar = new TweenOper();
         this.FTweenOperOutExpBar = new TweenOper();
         this.FTweenOperInFloatingBar = new TweenOper();
         this.FTweenOperOutFloatingBar = new TweenOper();
         this.FTweenOperInExpBar.duration = 10;
         this.FTweenOperOutExpBar.duration = 1000;
         this.FTweenOperInFloatingBar.duration = 10;
         this.FTweenOperOutFloatingBar.duration = 1000;
         this.FRepeatOperExpBar.loop = 1;
         this.FRepeatOperExpBar.children = [this.FTweenOperInExpBar,this.FTweenOperOutExpBar];
         this.FRepeatOperFloatingBar.loop = 1;
         this.FRepeatOperFloatingBar.children = [this.FTweenOperInFloatingBar,this.FTweenOperOutFloatingBar];
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DAILY_QUEST.RESOURCESID_DAILY_QUEST);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUIRewardList = null;
         super.ResourcesPerform_UIDispatch();
         this.FMC_Point = TUtilityReflection.CreateDisplayObjectInstance(CONST_DAILY_QUEST.RESOURCE_ClassName_POINT) as Sprite;
         addChild(this.FMC_Point);
         this.FDoubleSlot = this.FMC_Point[CONST_DAILY_QUEST.RESOURCE_Link_MC_DoubleSlot];
         this.FMC_BmpIcon = this.FDoubleSlot[CONST_DAILY_QUEST.RESOURCE_Link_MC_Bmp_Icon];
         this.FMC_FinishTag = this.FDoubleSlot[CONST_DAILY_QUEST.RESOURCE_Link_MC_FinishTag];
         this.FBitmap = new Bitmap();
         this.FMC_BmpIcon.addChild(this.FBitmap);
         this.FMC_FinishTag.visible = false;
         this.FMC_ExpBar = this.FMC_Point[CONST_DAILY_QUEST.RESOURCE_Link_MC_ExpBar];
         this.FMC_CurrentPoint = this.FMC_ExpBar[CONST_DAILY_QUEST.RESOURCE_Link_MC_CurrentPoint];
         this.FMC_YellowBar = this.FMC_ExpBar[CONST_DAILY_QUEST.RESOURCE_Link_MC_YellowBar];
         this.FMC_YellowBar.y += this.FMC_YellowBar.height;
         this.FTF_CurrentPoint = this.FMC_CurrentPoint[CONST_DAILY_QUEST.RESOURCE_Link_TF_CurrentPoint];
         this.FMC_GainRewardBT = this.FMC_Point[CONST_DAILY_QUEST.RESOURCE_Link_MC_GainRewardBT];
         TGameUtil.setButtonMode(this.FMC_GainRewardBT,true);
         _loc2_ = REWARD_LISTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Point[CONST_DAILY_QUEST.RESOURCE_Link_MC_RewardLists + _loc1_];
            _loc4_ = new TUIRewardList(this);
            _loc4_.Perform_UIDispatch(_loc3_);
            _loc4_.OnOver = this.ListOnOver;
            _loc4_.OnOut = this.ListOnOut;
            this.FMC_RewardLists[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FDailyTaskBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DailyTask);
         this.FDailyAwardBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DailyAward);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FUIWindowConfirmationCopy = new TUIWindowConfirmation(Parent);
         this.FUIWindowConfirmationCopy.OnOK = this.OnConfirmationOkCopy;
         this.FUIWindowConfirmationCopy.x = (FUICore.StageWidth - this.FUIWindowConfirmationCopy.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy.y = (FUICore.StageHeight - this.FUIWindowConfirmationCopy.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy);
      }
      
      private function ListOnOut(param1:TUIRewardList) : void
      {
         if(this.FListRewardOnOut != null)
         {
            this.FListRewardOnOut(param1);
         }
      }
      
      protected function ListOnOver(param1:TUIRewardList, param2:Object) : void
      {
         if(this.FListRewardOnOver != null)
         {
            this.FListRewardOnOver(param2);
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FMC_GainRewardBT.addEventListener(MouseEvent.CLICK,this.GainRewarOnClick);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FDailyTaskBin != null)
         {
            this.DoubleTaskUpdate();
         }
      }
      
      protected function OnConfirmationOkCopy(param1:Object) : void
      {
         this.TanKuangSiMiDa();
      }
      
      protected function GainRewarOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:TUIRewardList = null;
         var _loc5_:TAppliance = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         _loc6_ = this.FDailytask.IsAward.toString(2);
         _loc7_ = uint(_loc6_.length);
         if(_loc6_ == "0")
         {
            _loc7_ = 0;
         }
         _loc4_ = this.FMC_RewardLists[_loc7_];
         _loc5_ = _loc4_.Context as TAppliance;
         if(_loc5_.IDTemplate == CONST_COMMON.GetItemIDByType(3,0,null))
         {
            _loc2_ = int(_loc5_.Quantity);
            if(_loc4_.IsDouble)
            {
               _loc2_ *= 2;
            }
            _loc2_ += this.FCharacter.CreditMilitaryOrders;
            if(_loc2_ > this.FCharacter.XingDongLiMaxValue)
            {
               this.FUIWindowConfirmationCopy.Text = new ConsumeFrame(70320002).DescribeString;
               this.FUIWindowConfirmationCopy.Visible = true;
            }
         }
         if(!this.FUIWindowConfirmationCopy.Visible)
         {
            this.TanKuangSiMiDa();
         }
      }
      
      protected function TanKuangSiMiDa() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:TDailyAward = null;
         var _loc10_:uint = 0;
         _loc7_ = this.FDailytask.IsAward.toString(2);
         _loc10_ = uint(_loc7_.length);
         if(_loc7_ == "0")
         {
            _loc10_ = 0;
         }
         _loc4_ = uint(this.FDailyAwardBin.Count);
         _loc8_ = this.FCharacter.MainHero.Level;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc9_ = this.FDailyAwardBin.GetDatebaseByIndex(_loc3_) as TDailyAward;
            if(_loc8_ < _loc9_.Level1)
            {
               break;
            }
            _loc3_++;
         }
         _loc3_ -= 10;
         this.FAwardIndex = _loc3_ + _loc10_ + 1;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyTask_RewardReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeInt(this.FAwardIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.FMC_GainRewardBT.mouseEnabled = false;
      }
      
      protected function PointUpdat() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         this.FTF_CurrentPoint.text = this.FPoint.toString();
         _loc1_ = this.FPoint / TOTAL_POINT;
         if(_loc1_ > 1)
         {
            _loc1_ = 1;
         }
         _loc2_ = this.FMC_YellowBar.height * _loc1_;
         if(this.FCurrentPoint == this.FPoint)
         {
            return;
         }
         this.FTweenOperInExpBar.target = this.FMC_YellowBar;
         this.FTweenOperInExpBar.params = {
            "y":this.FMC_YellowBar.y,
            "ease":Cubic.easeIn
         };
         this.FTweenOperOutExpBar.target = this.FMC_YellowBar;
         this.FTweenOperOutExpBar.params = {
            "y":this.FMC_YellowBar.height - _loc2_ + this.FMC_YellowBar.height,
            "ease":Cubic.easeOut
         };
         this.FTweenOperInFloatingBar.target = this.FMC_CurrentPoint;
         this.FTweenOperInFloatingBar.params = {
            "y":this.FMC_CurrentPoint.y,
            "ease":Cubic.easeIn
         };
         this.FTweenOperOutFloatingBar.target = this.FMC_CurrentPoint;
         this.FTweenOperOutFloatingBar.params = {
            "y":this.FMC_YellowBar.height - _loc2_,
            "ease":Cubic.easeOut
         };
         this.FRepeatOperExpBar.execute();
         this.FRepeatOperFloatingBar.execute();
         this.FCurrentPoint = this.FPoint;
      }
      
      protected function ListTextUpdate() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TDailyAward = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:TArticle = null;
         var _loc10_:String = null;
         var _loc11_:uint = 0;
         var _loc12_:TAppliance = null;
         _loc2_ = this.FAppliances.length;
         while(_loc2_ > 0)
         {
            _loc12_ = this.FAppliances[_loc2_ - 1];
            _loc12_ = null;
            this.FAppliances.pop();
            _loc2_--;
         }
         _loc2_ = uint(this.FDailyAwardBin.Count);
         _loc3_ = this.FCharacter.MainHero.Level;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FDailyAwardBin.GetDatebaseByIndex(_loc1_) as TDailyAward;
            if(_loc3_ < _loc4_.Level1)
            {
               break;
            }
            _loc1_++;
         }
         _loc1_ -= 10;
         _loc5_ = 0;
         while(_loc5_ < REWARD_LISTS)
         {
            _loc10_ = "";
            _loc11_ = 0;
            _loc4_ = this.FDailyAwardBin.GetDatebaseByIndex(_loc5_ + _loc1_) as TDailyAward;
            _loc6_ = _loc4_.RewardsVect[0].Type;
            _loc7_ = _loc4_.RewardsVect[0].Code;
            _loc8_ = _loc4_.RewardsVect[0].Amount;
            _loc12_ = new TAppliance(0,0);
            _loc7_ = CONST_COMMON.GetItemIDByType(_loc6_,_loc7_,this.FArticleBins);
            _loc9_ = this.FArticleBins.GetDatebaseByIdentifier(_loc7_) as TArticle;
            _loc12_.Quality = _loc9_.Quality;
            _loc12_.Name = _loc9_.Name;
            _loc12_.RequirementLevel = _loc9_.Level;
            _loc12_.Description = _loc9_.FunctionDesc;
            _loc12_.SellValue = _loc9_.SellPrice;
            _loc12_.Quantity = _loc8_;
            _loc12_.IDTemplate = _loc9_.Identifier;
            this.FMC_RewardLists[_loc5_].Context = _loc12_;
            this.FMC_RewardLists[_loc5_].Update();
            this.FAppliances.push(_loc12_);
            _loc5_++;
         }
      }
      
      protected function ListUpdate(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         _loc5_ = this.FDailytask.IsAward.toString(2);
         _loc4_ = _loc5_.split("");
         _loc4_.reverse();
         if(this.FPoint >= 15)
         {
            this.FIndex = Math.floor((this.FPoint - GRADE) / GRADE);
         }
         else
         {
            this.FIndex = -1;
         }
         _loc2_ = 0;
         while(_loc2_ < REWARD_LISTS)
         {
            _loc3_ = uint(TUIRewardList.RENDERINGSTATE_Selected);
            if(_loc2_ > this.FIndex)
            {
               _loc3_ = uint(TUIRewardList.RENDERINGSTATE_Disabled);
               if(this.FDailytask.IsDouble == 0)
               {
                  this.FMC_RewardLists[_loc2_].IsDouble = false;
               }
            }
            else
            {
               if(_loc4_[_loc2_] == "1")
               {
                  _loc3_ = uint(TUIRewardList.RENDERINGSTATE_Normal);
               }
               if(this.FDailytask.IsDouble == 1)
               {
                  this.FMC_RewardLists[_loc2_].IsDouble = true;
               }
            }
            this.FMC_RewardLists[_loc2_].SetStatus(_loc3_,param1);
            _loc2_++;
         }
         if(this.FIndex == -1)
         {
            TGameUtil.setButtonMode(this.FMC_GainRewardBT,false);
            this.FMC_GainRewardBT.mouseEnabled = false;
         }
         else if(this.FMC_RewardLists[this.FIndex].MC_List.currentFrame == TUIRewardList.RENDERINGSTATE_Normal)
         {
            TGameUtil.setButtonMode(this.FMC_GainRewardBT,false);
            this.FMC_GainRewardBT.mouseEnabled = false;
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_GainRewardBT,true);
            this.FMC_GainRewardBT.mouseEnabled = true;
         }
      }
      
      protected function DoubleTaskUpdate() : void
      {
         var _loc1_:TDailyTask = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = uint(this.FDailyTaskBin.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.FDailyTaskBin.GetDatebaseByIndex(_loc2_) as TDailyTask;
            if(_loc1_.EventType == DOUBLE_TYPE)
            {
               TGameUtil.ShowImageByID(TGameUtil.Type_DailyTask,this.FBitmap,CONST_MODULES.MODULE_DailyQuest,_loc1_.Smallpicture);
            }
            _loc2_++;
         }
         if(this.FDailytask.IsDouble == 1)
         {
            this.FMC_FinishTag.visible = true;
         }
         else
         {
            this.FMC_FinishTag.visible = false;
         }
      }
      
      public function get AwardIndex() : uint
      {
         return this.FAwardIndex - 1;
      }
      
      public function get ListRewardOnOver() : Function
      {
         return this.FListRewardOnOver;
      }
      
      public function set ListRewardOnOver(param1:Function) : void
      {
         this.FListRewardOnOver = param1;
      }
      
      public function get ListRewardOnOut() : Function
      {
         return this.FListRewardOnOut;
      }
      
      public function set ListRewardOnOut(param1:Function) : void
      {
         this.FListRewardOnOut = param1;
      }
      
      public function update(param1:Boolean) : void
      {
         this.FPoint = this.FDailytask.Point;
         this.ListTextUpdate();
         this.ListUpdate(param1);
         this.PointUpdat();
      }
      
      public function awardListUpdate() : void
      {
         this.ListUpdate(false);
      }
      
      public function UpdateDouble() : void
      {
         this.FDailytask.IsDouble = 1;
         this.FMC_FinishTag.visible = true;
         this.ListUpdate(true);
      }
   }
}

