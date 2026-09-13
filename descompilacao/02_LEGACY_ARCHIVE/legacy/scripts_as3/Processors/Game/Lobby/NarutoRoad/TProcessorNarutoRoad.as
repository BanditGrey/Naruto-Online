package Processors.Game.Lobby.NarutoRoad
{
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.NarutoRoad.*;
   import Logics.Streamization.NarutoRoad.*;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.Hints.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_NARUTOROAD;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorNarutoRoad extends TProcessorLobbyWindows
   {
      
      protected static const SHOW_VALUE_STAMP:uint = 1000000;
      
      public static const GET_AWARD_SUCCEED:uint = 0;
      
      public static const STARTPAGE_ID:uint = 1001;
      
      public var SIZE_NarutoRoad_Width:int = 818;
      
      public var SIZE_NarutoRoad_Height:int = 563;
      
      public const SIZE_WindowBuyBox_Width:uint = 330;
      
      public const SIZE_WindowBuyBox_Height:uint = 274;
      
      public var TAB_TYPE_Naruto_ROAD:int = 0;
      
      public var TAB_TYPE_OBLIGATORY_COURSE:int = 1;
      
      protected var FProcessWindowNarutoRoad:TProcessorWindowNarutoRoad;
      
      protected var FProcessWindowObligatoryCourse:TProcessorWindowObligatoryCourses;
      
      protected var FUnstreamizerNarutoRoadGroup:TUnstreamizerNarutoRoadGroup;
      
      protected var FUnstreamizerNarutoRoadMission:TUnstreamizerNarutoRoadMission;
      
      protected var FBoundsNarutoRoad:TBounds;
      
      protected var FBoundsBuyBox:TBounds;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FTab_NarutoRoad:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FBtn_TabNarutoRoad:MovieClip;
      
      protected var FBtn_TabObligatoryCourses:MovieClip;
      
      protected var FNarutoRoadData:TNarutoRoadData;
      
      protected var FTabIndex:int;
      
      protected var FSelectTab:uint;
      
      protected var FSelectPageId:uint;
      
      protected var FSelectMissionId:uint;
      
      protected var FRewardStatus:Vector.<uint>;
      
      protected var FCompleteStatus:Vector.<uint>;
      
      protected var FOnGoto:Function;
      
      protected var FCheckEffect:Function;
      
      protected var FShowNarutoRoadTip:Function;
      
      protected var FObligatoryCoursesCount:Function;
      
      public function TProcessorNarutoRoad(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessWindowNarutoRoad = new TProcessorWindowNarutoRoad(this);
         this.FProcessWindowNarutoRoad.OnGoto = this.ProcessorOnGoto;
         this.FProcessWindowNarutoRoad.HintOnMove = ProcessorTipOnOver;
         this.FProcessWindowNarutoRoad.HintOnOut = ProcessorTipOnOut;
         this.FProcessWindowNarutoRoad.OnNarutoRoadInfoReq = this.ProcessorOnNarutoRoadInfoReq;
         this.FProcessWindowObligatoryCourse = new TProcessorWindowObligatoryCourses(this);
         this.FProcessWindowObligatoryCourse.OnGoto = this.ProcessorOnGoto;
         this.FBoundsNarutoRoad = new TBounds();
         this.FBoundsNarutoRoad.Width = this.SIZE_NarutoRoad_Width;
         this.FBoundsNarutoRoad.Height = this.SIZE_NarutoRoad_Height;
         ComponentBoundsCenter(this,this.FBoundsNarutoRoad);
         this.FTab_NarutoRoad = new TUITab(this);
         this.FTabVect = new Vector.<MovieClip>();
         this.FTabIndex = 0;
         this.FUnstreamizerNarutoRoadGroup = new TUnstreamizerNarutoRoadGroup();
         this.FUnstreamizerNarutoRoadMission = new TUnstreamizerNarutoRoadMission();
         this.FNarutoRoadData = SLogicsCore.NarutoRoadData;
         this.FSelectTab = 0;
         this.FSelectPageId = STARTPAGE_ID;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NARUTOROAD.RESOURCESID_Swf_NarutoRoad);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_NARUTOROAD.RESOURCE_ClassName_MC_NarutoRoad) as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_EffectLeft = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_EffectRight];
         this.FBtn_Close = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_BTN_Close];
         this.FBtn_TabNarutoRoad = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_Btn_TabNarutoRoad];
         this.FBtn_TabObligatoryCourses = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_Btn_TabObligatoryCourses];
         this.FTabVect.push(this.FBtn_TabNarutoRoad);
         this.FTabVect.push(this.FBtn_TabObligatoryCourses);
         _loc1_ = 0;
         while(_loc1_ < this.FTabVect.length)
         {
            this.FTab_NarutoRoad.SetTabByIndex(this.FTabVect[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FTab_NarutoRoad.OnSwitch = this.ChangeTabOnSwitch;
         this.FTab_NarutoRoad.Init();
         this.FProcessWindowNarutoRoad.Perform_UIDispatch(this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_NarutoRoad]);
         this.FProcessWindowObligatoryCourse.Perform_UIDispatch(this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_ObligatoryCourses]);
         addChild(this.FProcessWindowNarutoRoad);
         addChild(this.FProcessWindowObligatoryCourse);
         FOverlayerHint = new TOverlayerHint(this.Parent.Parent);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FIsResourcesLoadCompleted && Visible)
         {
            this.FProcessWindowNarutoRoad.UpdateEffectsGlow();
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NarutoRoad_LoadTaskRet,this.PerformPacket_SC_LoadTaskRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NarutoRoad_TaskDataRet,this.PerformPacket_SC_TaskDataRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NarutoRoad_BuyRet,this.PerformPacket_SC_BuyRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NarutoRoad_GetRewardRet,this.PerformPacket_SC_GetAwardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NarutoRoad_NotifyCompleteTask,this.PerformPacket_SC_NotifyCompleteTask);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NarutoRoad_ObligatoryCoursesRet,this.PerformPacket_SC_ObligatoryCoursesRet);
      }
      
      protected function PerformPacket_SC_LoadTaskRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:TNarutoRoadMission = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc3_ = param1.Data;
         _loc4_ = _loc3_.readUnsignedInt();
         _loc5_ = _loc3_.readUnsignedInt();
         _loc7_ = _loc3_.readByte();
         _loc6_ = _loc3_.readUnsignedShort();
         _loc2_ = 0;
         while(_loc2_ < _loc6_)
         {
            _loc9_ = uint(_loc3_.readByte());
            _loc10_ = uint(_loc3_.readByte());
            if(this.FRewardStatus == null)
            {
               this.FRewardStatus = new Vector.<uint>(_loc6_);
            }
            if(this.FCompleteStatus == null)
            {
               this.FCompleteStatus = new Vector.<uint>(_loc6_);
            }
            this.FRewardStatus[_loc2_] = _loc9_;
            this.FCompleteStatus[_loc2_] = _loc10_;
            _loc2_++;
         }
         this.FProcessWindowNarutoRoad.SetTabStatus(this.FRewardStatus,this.FCompleteStatus);
         this.FUnstreamizerNarutoRoadGroup.UnstreamizationNarutoRoadMission(_loc4_,this.FNarutoRoadData,SResourcesCore.ResourceBin);
         this.FNarutoRoadData.CurrShowTaskId = _loc4_;
         if(_loc4_ != 0)
         {
            _loc8_ = this.FNarutoRoadData.GetMissionById(_loc4_);
            _loc8_.MissionCount = _loc5_;
            _loc8_.MissionStatus = _loc7_;
         }
         if(this.FShowNarutoRoadTip != null)
         {
            this.FShowNarutoRoadTip(this);
         }
         this.ProcessorOnCheckEffect();
      }
      
      protected function PerformPacket_SC_TaskDataRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerNarutoRoadGroup.Unstreamize(_loc3_,this.FNarutoRoadData,SResourcesCore.ResourceBin);
         if(this.FSelectTab == 0)
         {
            this.FProcessWindowNarutoRoad.Visible = true;
            this.FProcessWindowObligatoryCourse.visible = false;
         }
         this.FProcessWindowNarutoRoad.Updata();
      }
      
      protected function PerformPacket_SC_BuyRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TNarutoRoadGroup = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedInt();
         _loc5_ = uint(_loc3_.readByte());
         _loc6_ = this.FNarutoRoadData.GetGroupByID(_loc4_);
         _loc6_.BuyCount[_loc5_] = _loc6_.BuyCount[_loc5_] + 1;
         this.FProcessWindowNarutoRoad.BuyUpdateShop();
         EffectGenerateText(STRING_NARUTOROAD.STRING_BuySussful);
      }
      
      protected function PerformPacket_SC_GetAwardRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TNarutoRoadMission = null;
         var _loc7_:uint = 0;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedInt();
         _loc5_ = _loc3_.readUnsignedInt();
         _loc6_ = this.FNarutoRoadData.GetMissionById(_loc4_);
         if(_loc6_ != null)
         {
            if(_loc5_ == 0)
            {
               _loc6_.RewardType = 1;
            }
            else if(_loc5_ == 1)
            {
               _loc6_.VipRewardType = 1;
            }
            _loc7_ = uint(SLogicsCore.Character.VipLevel);
            _loc6_.TipValue = _loc6_.MissionStatus * 2 * SHOW_VALUE_STAMP;
            if(_loc6_.MissionStatus == 2)
            {
               _loc6_.TipValue += _loc6_.HasRewardCanGet(_loc7_) > 0 ? SHOW_VALUE_STAMP : 0;
            }
            if(_loc6_.IsClose(_loc7_))
            {
               _loc6_.TipValue = -SHOW_VALUE_STAMP;
            }
            _loc6_.PopTipValue = _loc6_.MissionStatus * 2 * SHOW_VALUE_STAMP;
            if(_loc6_.HasRewardCanGet(_loc7_) <= 0)
            {
               _loc6_.PopTipValue = -SHOW_VALUE_STAMP;
            }
            this.FProcessWindowNarutoRoad.GetAwardUpdata();
         }
         EffectGenerateText(STRING_NARUTOROAD.STRING_GetRewardSussful);
         this.PacketPerform_CS_NarutoRoadTaskId();
      }
      
      protected function PerformPacket_SC_NotifyCompleteTask(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TNarutoRoadMission = null;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = this.FNarutoRoadData.GetMissionById(_loc3_);
         if(_loc5_ != null)
         {
            _loc5_.MissionCount = _loc4_;
            _loc5_.MissionStatus = 2;
            _loc6_ = uint(SLogicsCore.Character.VipLevel);
            _loc5_.TipValue = _loc5_.MissionStatus * 2 * SHOW_VALUE_STAMP;
            if(_loc5_.MissionStatus == 2)
            {
               _loc5_.TipValue += _loc5_.HasRewardCanGet(_loc6_) * SHOW_VALUE_STAMP;
            }
            if(_loc5_.IsClose(_loc6_))
            {
               _loc5_.TipValue = -SHOW_VALUE_STAMP;
            }
            _loc5_.PopTipValue = _loc5_.MissionStatus * 2 * SHOW_VALUE_STAMP;
            if(_loc5_.HasRewardCanGet(_loc6_) <= 0)
            {
               _loc5_.PopTipValue = -SHOW_VALUE_STAMP;
            }
         }
         this.PacketPerform_CS_NarutoRoadTaskId();
      }
      
      protected function PerformPacket_SC_ObligatoryCoursesRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerNarutoRoadGroup.UnstreamizeObligatoryCourses(_loc3_,this.FNarutoRoadData,SResourcesCore.ResourceBin);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessWindowObligatoryCourse.NotifyWindow();
         }
         if(this.FObligatoryCoursesCount != null)
         {
            this.FObligatoryCoursesCount(this,this.FNarutoRoadData.GetObligatoryCoursesCount());
         }
      }
      
      protected function PacketPerform_CS_NarutoRoadTaskId() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoRoad_LoadTaskReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FTabIndex)
         {
            return;
         }
         this.FTabIndex = _loc2_;
         switch(this.FTabIndex)
         {
            case this.TAB_TYPE_Naruto_ROAD:
               this.FProcessWindowObligatoryCourse.Visible = false;
               this.FProcessWindowNarutoRoad.Visible = true;
               break;
            case this.TAB_TYPE_OBLIGATORY_COURSE:
               this.FProcessWindowNarutoRoad.Visible = false;
               this.FProcessWindowObligatoryCourse.Visible = true;
               this.FProcessWindowObligatoryCourse.NotifyWindow();
         }
      }
      
      protected function ProcessorOnGoto(param1:Object, param2:uint) : void
      {
         ProcessorClose();
         if(this.FOnGoto != null)
         {
            this.FOnGoto(param1,param2);
         }
      }
      
      protected function ProcessorOnCheckEffect() : void
      {
         if(this.FCheckEffect != null)
         {
            this.FCheckEffect(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_NarutoRoad,this.FNarutoRoadData.CheckEffect(SLogicsCore.Character.VipLevel));
         }
      }
      
      protected function ProcessorOnNarutoRoadInfoReq(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoRoad_TaskDataReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorStreamData(param1:ByteArray) : void
      {
         var _loc2_:TNarutoRoadMission = null;
         var _loc3_:uint = 0;
         if(param1 != null && param1.length > 0)
         {
            this.FSelectTab = param1.readUnsignedInt();
            if(this.FSelectTab == 0)
            {
               this.FSelectPageId = param1.readUnsignedInt();
               this.FSelectMissionId = param1.readUnsignedInt();
            }
         }
         else
         {
            _loc3_ = uint(SLogicsCore.Character.VipLevel);
            _loc2_ = SLogicsCore.NarutoRoadData.GetPopMission(_loc3_);
            if(_loc2_ != null)
            {
               this.FSelectPageId = _loc2_.NarutoRoadTask.Type;
               this.FSelectMissionId = _loc2_.Identifier;
            }
         }
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function get CheckEffect() : Function
      {
         return this.FCheckEffect;
      }
      
      public function set CheckEffect(param1:Function) : void
      {
         this.FCheckEffect = param1;
      }
      
      public function get ShowNarutoRoadTip() : Function
      {
         return this.FShowNarutoRoadTip;
      }
      
      public function set ShowNarutoRoadTip(param1:Function) : void
      {
         this.FShowNarutoRoadTip = param1;
      }
      
      public function get ObligatoryCoursesCount() : Function
      {
         return this.FObligatoryCoursesCount;
      }
      
      public function set ObligatoryCoursesCount(param1:Function) : void
      {
         this.FObligatoryCoursesCount = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessWindowNarutoRoad.Load();
            this.FProcessWindowObligatoryCourse.Load();
            return;
         }
         this.FProcessWindowNarutoRoad.SetSelectPage(this.FSelectPageId - STARTPAGE_ID,this.FSelectMissionId);
         this.ProcessorOnNarutoRoadInfoReq(this.FSelectPageId);
         this.ChangeTabOnSwitch(this.FSelectTab);
         this.FTabIndex = this.FSelectTab;
         this.FTab_NarutoRoad.TabIndex = this.FSelectTab;
         if(this.FMC_EffectLeft != null)
         {
            this.FMC_EffectLeft.play();
         }
         if(this.FMC_EffectRight != null)
         {
            this.FMC_EffectRight.play();
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FSelectTab = 0;
         this.FSelectPageId = STARTPAGE_ID;
         this.FSelectMissionId = 0;
      }
      
      public function ProcessorChangeVipLv() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(Visible == false)
         {
            return;
         }
         this.FProcessWindowNarutoRoad.VipLevelUpdate();
      }
      
      public function TestInit1() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:Array = null;
         this.FUnstreamizerNarutoRoadGroup.UnstreamizationNarutoRoadMission(20002,this.FNarutoRoadData,SResourcesCore.ResourceBin);
         if(this.FShowNarutoRoadTip != null)
         {
            this.FShowNarutoRoadTip(this);
         }
      }
      
      public function TestInit2() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:ByteArray = null;
         var _loc3_:Array = null;
         _loc3_ = [{
            "id":20001,
            "status":0,
            "value":1,
            "type":0,
            "viptype":0
         },{
            "id":20002,
            "status":1,
            "value":2,
            "type":1,
            "viptype":0
         },{
            "id":20003,
            "status":0,
            "value":3,
            "type":0,
            "viptype":1
         },{
            "id":20004,
            "status":1,
            "value":4,
            "type":1,
            "viptype":1
         },{
            "id":20005,
            "status":0,
            "value":5,
            "type":0,
            "viptype":0
         },{
            "id":20006,
            "status":1,
            "value":6,
            "type":0,
            "viptype":0
         },{
            "id":20007,
            "status":2,
            "value":7,
            "type":0,
            "viptype":1
         },{
            "id":20008,
            "status":2,
            "value":7,
            "type":0,
            "viptype":0
         },{
            "id":20009,
            "status":2,
            "value":7,
            "type":1,
            "viptype":1
         },{
            "id":20010,
            "status":2,
            "value":7,
            "type":1,
            "viptype":0
         }];
         _loc2_ = new ByteArray();
         _loc2_.writeShort(0);
         _loc2_.writeShort(1002);
         _loc2_.writeShort(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_.writeInt(_loc3_[_loc1_].id);
            _loc2_.writeByte(_loc3_[_loc1_].status);
            _loc2_.writeShort(_loc3_[_loc1_].value);
            _loc2_.writeByte(_loc3_[_loc1_].type);
            _loc2_.writeByte(_loc3_[_loc1_].viptype);
            _loc1_++;
         }
         _loc2_.writeShort(3);
         _loc2_.writeByte(4);
         _loc2_.writeByte(5);
         _loc2_.writeByte(6);
         _loc2_.position = 0;
         this.FUnstreamizerNarutoRoadGroup.Unstreamize(_loc2_,this.FNarutoRoadData,SResourcesCore.ResourceBin);
         this.FProcessWindowNarutoRoad.Visible = true;
         this.FProcessWindowObligatoryCourse.visible = false;
         this.FProcessWindowNarutoRoad.Updata();
      }
      
      public function TestInit3() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:ByteArray = null;
         var _loc3_:Array = null;
         _loc3_ = [{
            "id":20001,
            "count":0
         },{
            "id":20002,
            "count":1
         },{
            "id":20003,
            "count":2
         },{
            "id":20004,
            "count":3
         },{
            "id":20005,
            "count":4
         },{
            "id":20006,
            "count":5
         },{
            "id":20007,
            "count":6
         },{
            "id":20008,
            "count":7
         },{
            "id":20009,
            "count":8
         },{
            "id":20010,
            "count":9
         }];
         _loc2_ = new ByteArray();
         _loc2_.writeShort(0);
         _loc2_.writeShort(1002);
         _loc2_.writeShort(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_.writeInt(_loc3_[_loc1_].id);
            _loc2_.writeByte(_loc3_[_loc1_].status);
            _loc2_.writeShort(_loc3_[_loc1_].value);
            _loc2_.writeByte(_loc3_[_loc1_].type);
            _loc2_.writeByte(_loc3_[_loc1_].viptype);
            _loc1_++;
         }
         _loc2_.writeShort(3);
         _loc2_.writeByte(4);
         _loc2_.writeByte(5);
         _loc2_.writeByte(6);
         _loc2_.position = 0;
         this.FUnstreamizerNarutoRoadGroup.Unstreamize(_loc2_,this.FNarutoRoadData,SResourcesCore.ResourceBin);
      }
   }
}

