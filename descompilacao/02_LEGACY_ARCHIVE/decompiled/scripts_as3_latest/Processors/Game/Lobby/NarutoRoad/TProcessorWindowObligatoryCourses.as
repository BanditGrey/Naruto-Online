package Processors.Game.Lobby.NarutoRoad
{
   import Components.ScrollBar.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Logics.NarutoRoad.TNarutoRoadData;
   import Logics.SLogicsCore;
   import Logics.Streamization.NarutoRoad.TUnstreamizerNarutoRoadGroup;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.NarutoRoad.Components.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowObligatoryCourses extends TProcessorLobbyWindow
   {
      
      public static const MIN_SCROLL_HEIGHT:Number = 412;
      
      public static const ITEM_STAMP:Number = 0;
      
      public static const SINGLE_ITEM_STAMP:Number = 68;
      
      protected var FMC_Scene:Sprite;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FObligatoryList:Vector.<TNarutoRoadObligatory>;
      
      protected var FFreeObligatoryList:Vector.<TNarutoRoadObligatory>;
      
      protected var FNarutoRoadData:TNarutoRoadData;
      
      protected var FOnGoto:Function;
      
      public function TProcessorWindowObligatoryCourses(param1:TUIComponent)
      {
         super(param1);
         this.FObligatoryList = new Vector.<TNarutoRoadObligatory>();
         this.FFreeObligatoryList = new Vector.<TNarutoRoadObligatory>();
         this.FNarutoRoadData = SLogicsCore.NarutoRoadData;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FMC_List = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_MC_List];
         this.FScrollBar = new TScrollBar(this.FMC_List,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:TNarutoRoadObligatory = null;
         _loc3_ = this.FNarutoRoadData.ObligatoryCoursesCount;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            if(_loc1_ < this.FObligatoryList.length)
            {
               _loc4_ = this.FObligatoryList[_loc1_];
            }
            else
            {
               _loc4_ = this.MakeNarutoRoadObligatory();
               this.FObligatoryList.push(_loc4_);
               this.FScrollBar.AddItem(_loc4_);
            }
            _loc4_.SetObligatory(this.FNarutoRoadData.GetObligatoryCoursesByIndex(_loc1_));
            _loc4_.UpdataUI();
            _loc1_++;
         }
         _loc3_ = this.FObligatoryList.length;
         _loc2_ = int(_loc3_ - 1);
         while(_loc2_ >= _loc1_)
         {
            _loc4_ = this.FScrollBar.DelItem(_loc2_) as TNarutoRoadObligatory;
            this.FObligatoryList.splice(_loc2_,1);
            this.FFreeObligatoryList.push(_loc4_);
            _loc2_--;
         }
      }
      
      protected function MakeNarutoRoadObligatory() : TNarutoRoadObligatory
      {
         var _loc1_:TNarutoRoadObligatory = null;
         if(this.FFreeObligatoryList.length <= 0)
         {
            _loc1_ = new TNarutoRoadObligatory(this);
            _loc1_.FightGoto = this.FightGoto;
         }
         else
         {
            _loc1_ = this.FFreeObligatoryList.pop();
         }
         return _loc1_;
      }
      
      protected function FightGoto(param1:Object, param2:uint) : void
      {
         if(this.FOnGoto != null)
         {
            this.FOnGoto(param1,param2);
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
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
      }
      
      public function NotifyWindow() : void
      {
         this.UpdateUI();
      }
      
      public function TestInit() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:ByteArray = null;
         var _loc3_:Array = null;
         var _loc4_:TUnstreamizerNarutoRoadGroup = null;
         _loc4_ = new TUnstreamizerNarutoRoadGroup();
         _loc3_ = [{
            "id":10001,
            "status":0
         },{
            "id":10002,
            "status":1
         },{
            "id":10003,
            "status":2
         },{
            "id":10008,
            "status":7
         },{
            "id":10009,
            "status":8
         },{
            "id":10010,
            "status":9
         },{
            "id":10011,
            "status":1
         },{
            "id":10012,
            "status":2
         },{
            "id":10013,
            "status":3
         },{
            "id":10014,
            "status":4
         },{
            "id":10015,
            "status":5
         },{
            "id":10016,
            "status":6
         },{
            "id":10017,
            "status":7
         },{
            "id":10018,
            "status":8
         },{
            "id":10019,
            "status":9
         },{
            "id":10020,
            "status":10
         }];
         _loc2_ = new ByteArray();
         _loc2_.writeShort(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_.writeInt(_loc3_[_loc1_].id);
            _loc2_.writeInt(_loc3_[_loc1_].status);
            _loc1_++;
         }
         _loc2_.position = 0;
         _loc4_.UnstreamizeObligatoryCourses(_loc2_,this.FNarutoRoadData,SResourcesCore.ResourceBin);
         this.UpdateUI();
      }
   }
}

