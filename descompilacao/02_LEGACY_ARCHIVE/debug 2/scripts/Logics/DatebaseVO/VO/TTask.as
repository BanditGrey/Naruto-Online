package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TTask extends TDatebaseVO
   {
      
      protected var FType:int;
      
      protected var FEventType:int;
      
      protected var FTaskRewards:Vector.<TTaskReward>;
      
      protected var FCancel:int;
      
      protected var FName:String;
      
      protected var FPreTaskId:int;
      
      protected var FAccept:int;
      
      protected var FTransLevel:int;
      
      protected var FAutoAccept:int;
      
      protected var FInstant:int;
      
      protected var FPlot:String;
      
      protected var FDescription:String;
      
      protected var FGuideBefor:String;
      
      protected var FGuide:String;
      
      protected var FGuideEnd:String;
      
      protected var FTalkBefor:String;
      
      protected var FTalkEnd:String;
      
      protected var FStartNpcId:int;
      
      protected var FFinishNpcId:int;
      
      protected var FPoint:int;
      
      protected var FCampId:int;
      
      protected var FNeedKillTime:int;
      
      protected var FInitKillTime:int;
      
      protected var FRewards:String;
      
      protected var FComplete:String;
      
      protected var FContent:String;
      
      public function TTask()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FEventType);
         param1.writeUnsignedInt(this.FPoint);
         TUtilityString.FlushUTF(param1,this.FRewards);
         param1.writeUnsignedInt(this.FCancel);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FPreTaskId);
         param1.writeUnsignedInt(this.FAccept);
         param1.writeUnsignedInt(this.FTransLevel);
         param1.writeUnsignedInt(this.FAutoAccept);
         param1.writeUnsignedInt(this.FInstant);
         TUtilityString.FlushUTF(param1,this.FComplete);
         TUtilityString.FlushUTF(param1,this.FContent);
         TUtilityString.FlushUTF(param1,this.FPlot);
         TUtilityString.FlushUTF(param1,this.FDescription);
         TUtilityString.FlushUTF(param1,this.FGuideBefor);
         TUtilityString.FlushUTF(param1,this.FGuide);
         TUtilityString.FlushUTF(param1,this.FGuideEnd);
         TUtilityString.FlushUTF(param1,this.FTalkBefor);
         TUtilityString.FlushUTF(param1,this.FTalkEnd);
         param1.writeUnsignedInt(this.FStartNpcId);
         param1.writeUnsignedInt(this.FFinishNpcId);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:TTaskReward = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         this.FType = param1.readUnsignedInt();
         this.FEventType = param1.readUnsignedInt();
         this.FPoint = param1.readUnsignedInt();
         this.FRewards = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FRewards);
         _loc7_ = _loc4_.rewards as Array;
         _loc3_ = int(_loc7_.length);
         this.FTaskRewards = new Vector.<TTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = new TTaskReward(_loc7_[_loc2_]);
            this.FTaskRewards[_loc2_] = _loc8_;
            _loc2_++;
         }
         this.FCancel = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FPreTaskId = param1.readUnsignedInt();
         this.FAccept = param1.readUnsignedInt();
         this.FTransLevel = param1.readUnsignedInt();
         this.FAutoAccept = param1.readUnsignedInt();
         this.FInstant = param1.readUnsignedInt();
         this.FComplete = TUtilityString.FetchUTF(param1);
         if(this.FComplete == null || this.FComplete.length <= 0)
         {
            this.FComplete = "{}";
         }
         _loc4_ = Json.decode(this.FComplete);
         if(_loc4_.task != null)
         {
            _loc10_ = _loc4_.task as Array;
            _loc3_ = int(_loc10_.length);
            this.FCampId = _loc10_[0].campId;
            this.FNeedKillTime = _loc10_[0].value;
         }
         this.FContent = TUtilityString.FetchUTF(param1);
         if(this.FContent == null || this.FContent.length <= 0)
         {
            this.FContent = "{}";
         }
         _loc4_ = Json.decode(this.FContent);
         if(_loc4_.task != null)
         {
            _loc9_ = _loc4_.task as Array;
            _loc3_ = int(_loc9_.length);
            this.FInitKillTime = _loc9_[0].init;
         }
         this.FPlot = TUtilityString.FetchUTF(param1);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FGuideBefor = TUtilityString.FetchUTF(param1);
         this.FGuide = TUtilityString.FetchUTF(param1);
         this.FGuideEnd = TUtilityString.FetchUTF(param1);
         this.FTalkBefor = TUtilityString.FetchUTF(param1);
         this.FTalkEnd = TUtilityString.FetchUTF(param1);
         this.FStartNpcId = param1.readUnsignedInt();
         this.FFinishNpcId = param1.readUnsignedInt();
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get EventType() : int
      {
         return this.FEventType;
      }
      
      public function get Cancel() : int
      {
         return this.FCancel;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get PreTaskId() : int
      {
         return this.FPreTaskId;
      }
      
      public function get Accept() : int
      {
         return this.FAccept;
      }
      
      public function get TransLevel() : int
      {
         return this.FTransLevel;
      }
      
      public function get AutoAccept() : int
      {
         return this.FAutoAccept;
      }
      
      public function get Instant() : int
      {
         return this.FInstant;
      }
      
      public function get Plot() : String
      {
         return this.FPlot;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get GuideBefor() : String
      {
         return this.FGuideBefor;
      }
      
      public function get Guide() : String
      {
         return this.FGuide;
      }
      
      public function get GuideEnd() : String
      {
         return this.FGuideEnd;
      }
      
      public function get TalkBefor() : String
      {
         return this.FTalkBefor;
      }
      
      public function get TalkEnd() : String
      {
         return this.FTalkEnd;
      }
      
      public function get StartNpcId() : int
      {
         return this.FStartNpcId;
      }
      
      public function get FinishNpcId() : int
      {
         return this.FFinishNpcId;
      }
      
      public function get TaskRewards() : Vector.<TTaskReward>
      {
         return this.FTaskRewards;
      }
      
      public function get CampId() : int
      {
         return this.FCampId;
      }
      
      public function get NeedKillTime() : int
      {
         return this.FNeedKillTime;
      }
      
      public function get InitKillTime() : int
      {
         return this.FInitKillTime;
      }
      
      public function get Point() : int
      {
         return this.FPoint;
      }
      
      public function get Rewards() : String
      {
         return this.FRewards;
      }
      
      public function get Complete() : String
      {
         return this.FComplete;
      }
      
      public function get Content() : String
      {
         return this.FContent;
      }
   }
}

