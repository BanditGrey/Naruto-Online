package Processors.Game.Lobby.MainScene.Role
{
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Agent.SParametersCore;
   import Logics.Characters.MoveRole.*;
   import Logics.Quests.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TUIRoleNpc extends TUIRole
   {
      
      public static var FOnNpcClicked:Function;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FNpcHeadTextureID:uint;
      
      protected var FNPcStyleTextureID:uint;
      
      protected var FNpcQuestes:TQuests;
      
      protected var FInitOver:Boolean;
      
      protected var FCursorHovering:Boolean;
      
      protected var FRoleData:TRoleNpc;
      
      public function TUIRoleNpc(param1:TUIComponent)
      {
         super(param1);
         this.FNpcQuestes = new TQuests();
      }
      
      public static function IfCityDoor(param1:TUIRoleNpc) : Boolean
      {
         if(param1.RoleData.RoleTemplateID == 22100001 || param1.RoleData.RoleTemplateID == 22200013)
         {
            return true;
         }
         return false;
      }
      
      override protected function DoAfterLoadResourceOver() : void
      {
         var _loc1_:TAnimationSequence = null;
         var _loc2_:TAnimationFrame = null;
         super.DoAfterLoadResourceOver();
         if(SParametersCore.AgentID != CONST_PLATE.ID_PLATE_RUSSIA || SParametersCore.AgentID != CONST_PLATE.ID_PLATE_RU_WIKI)
         {
            FTextFiledNameFormat.font = CONST_FONTLIBRARY.NormalFounts;
         }
         else
         {
            FTextFiledNameFormat.font = CONST_FONTLIBRARY.FONT_NAME_Naruto_UI_00;
         }
         _loc1_ = FTexture.GetAnimationSequenceByIndex(0);
         _loc2_ = _loc1_.GetAnimationFrameByIndex(0);
         FTextFiledName.filters = NameFilters;
         FTextFiledName.text = this.FRoleData.RoleName;
         FTextFiledName.textColor = 16777215;
         FTextFiledName.y = -FTextFiledName.height;
         FTextFiledName.x = _loc2_.Pivot.X - FTextFiledName.width / 2;
         FTextFiledName.setTextFormat(FTextFiledNameFormat);
         if(IfCityDoor(this))
         {
            FTextFiledName.visible = false;
         }
         if(this.FMC_Icon == null)
         {
            this.FMC_Icon = TUtilityReflection.CreateDisplayObjectInstance("QuestBadge") as MovieClip;
            addChild(this.FMC_Icon);
         }
         this.FMC_Icon.x = _loc2_.Pivot.X - this.FMC_Icon.width / 2;
         this.FMC_Icon.y = -this.FMC_Icon.height - FTextFiledName.height;
         this.FInitOver = true;
         this.UpdateNpcHeadIconStatus();
      }
      
      protected function SetNpcMcStatus() : void
      {
         this.FMC_Icon.visible = true;
         switch(this.RoleData.UserType)
         {
            case CONST_NPC.NPC_FUNCTION_STONE:
               this.FMC_Icon.gotoAndStop(3);
               break;
            case CONST_NPC.NPC_FUNCTION_PUB:
               this.FMC_Icon.gotoAndStop(4);
               break;
            case CONST_NPC.NPC_FUNCTION_MADE:
               this.FMC_Icon.gotoAndStop(5);
               break;
            case CONST_NPC.NPC_FUNCTION_COPY:
               this.FMC_Icon.gotoAndStop(6);
               break;
            case CONST_NPC.NPC_FUNCTION_GODEQUIP:
               this.FMC_Icon.gotoAndStop(7);
               break;
            case CONST_NPC.NPC_FUNCTION_MASTERROAD:
               this.FMC_Icon.gotoAndStop(8);
               break;
            case CONST_NPC.NPC_FUNCTION_YUELAO:
               this.FMC_Icon.gotoAndStop(9);
               break;
            case CONST_NPC.NPC_FUNCTION_WAREHOUSE:
               this.FMC_Icon.gotoAndStop(10);
               break;
            default:
               this.FMC_Icon.visible = false;
         }
      }
      
      protected function GetFrameByStatus(param1:int) : String
      {
         switch(param1)
         {
            case CONST_QUEST.STATE_ACCEPT:
               return CONST_QUEST.RESOURCE_MC_Exclamation;
            case CONST_QUEST.STATE_TASKING:
               return CONST_QUEST.RESOURCE_MC_Question;
            case CONST_QUEST.STATE_TASKBACK:
               return CONST_QUEST.RESOURCE_MC_Question;
            default:
               return null;
         }
      }
      
      protected function SetNpcQuestStatus(param1:TQuest) : void
      {
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         _loc2_ = this.GetFrameByStatus(param1.TaskState);
         if(_loc2_ == null)
         {
            return;
         }
         this.FMC_Icon.visible = true;
         this.FMC_Icon.gotoAndStop(_loc2_);
         _loc3_ = this.FMC_Icon[_loc2_];
         switch(param1.TaskState)
         {
            case CONST_QUEST.STATE_ACCEPT:
               _loc3_.gotoAndStop(1);
               break;
            case CONST_QUEST.STATE_TASKING:
               _loc3_.gotoAndStop(2);
               break;
            case CONST_QUEST.STATE_TASKBACK:
               _loc3_.gotoAndStop(1);
         }
      }
      
      protected function UpdateNpcHeadIconStatus() : void
      {
         var _loc1_:Boolean = false;
         if(this.FInitOver)
         {
            _loc1_ = IfCityDoor(this);
            if(this.FNpcQuestes.Count > 0 && !_loc1_)
            {
               this.SetNpcQuestStatus(this.FNpcQuestes.GetQuestByIndex(0));
            }
            else
            {
               this.SetNpcMcStatus();
            }
         }
      }
      
      public function AddNewQuest(param1:TQuest) : void
      {
         this.FNpcQuestes.Add(param1);
         this.FNpcQuestes.SortByQuestState();
         this.UpdateNpcHeadIconStatus();
      }
      
      public function DeleteQuest(param1:TQuest) : void
      {
         this.FNpcQuestes.DeleteQuestByIdentifier(param1.Identifier);
         this.UpdateNpcHeadIconStatus();
      }
      
      public function UpdateQuest(param1:TQuest) : void
      {
         if(param1.TaskState == CONST_QUEST.STATE_ALREADYBACK)
         {
            this.DeleteQuest(param1);
         }
         this.UpdateNpcHeadIconStatus();
      }
      
      override protected function HandleOnMouseOver(param1:MouseEvent) : void
      {
         this.filters = FFilters;
         this.FCursorHovering = true;
      }
      
      override protected function HandleOnMouseMove(param1:MouseEvent) : void
      {
         FUICore.MouseCaptureSet(this);
      }
      
      override protected function HandleOnMouseOut(param1:MouseEvent) : void
      {
         this.filters = null;
         FUICore.MouseCaptureRelease(this);
         this.FCursorHovering = false;
      }
      
      override protected function HandleOnMouseClick(param1:MouseEvent) : void
      {
         super.HandleOnMouseClick(param1);
         if(FOnNpcClicked != null)
         {
            FOnNpcClicked(this);
         }
         param1.stopImmediatePropagation();
      }
      
      override public function get Cursor() : uint
      {
         if(this.FCursorHovering)
         {
            return CONST_CURSOR.CURSORID_NPC;
         }
         return CONST_CURSOR.CURSORID_Default;
      }
      
      override public function get CursorDisplayObject() : TUIComponent
      {
         return this.Parent;
      }
      
      public function set RoleData(param1:TRoleNpc) : void
      {
         this.FRoleData = param1;
      }
      
      public function get RoleData() : TRoleNpc
      {
         return this.FRoleData;
      }
      
      public function set NpcHeadTextureID(param1:uint) : void
      {
         this.FNpcHeadTextureID = param1;
      }
      
      public function set NPcStyleTextureID(param1:uint) : void
      {
         this.FNPcStyleTextureID = param1;
      }
      
      public function get NpcQuestes() : TQuests
      {
         return this.FNpcQuestes;
      }
      
      public function get NPcStyleTextureID() : uint
      {
         return this.FNPcStyleTextureID;
      }
      
      override public function UpdateData() : void
      {
         super.UpdateData();
      }
      
      override public function UpdateView() : void
      {
         super.UpdateView();
      }
      
      public function SimulateNpcClick() : void
      {
         if(FOnNpcClicked != null)
         {
            FOnNpcClicked(this);
         }
      }
      
      override public function Release() : void
      {
         super.Release();
      }
   }
}

