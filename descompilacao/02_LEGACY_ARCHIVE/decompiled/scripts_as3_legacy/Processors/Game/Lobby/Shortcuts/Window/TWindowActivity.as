package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.*;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.Coordinate.TQueryCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.SLogicsCore;
   import Logics.Unlocks.TUnlock;
   import Logics.Unlocks.TUnlocks;
   import Processors.Game.Common.Effects.Display.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TWindowActivity extends TUIComponent
   {
      
      public static const POSITION_Activity:uint = CONST_SHORTCUTS.POSITION_Activity;
      
      public static const TYPE_Activity_SubmitBug:uint = CONST_SHORTCUTS.TYPE_Activity_SubmitBug;
      
      public static const TYPE_Activity_Arena:uint = CONST_SHORTCUTS.TYPE_Activity_Arena;
      
      public static const TYPE_Activity_KillHeros:uint = CONST_SHORTCUTS.TYPE_Activity_KillHeros;
      
      public static const TYPE_Activity_Sign:uint = CONST_SHORTCUTS.TYPE_Activity_Sign;
      
      public static const TYPE_Activity_CopyHero:uint = CONST_SHORTCUTS.TYPE_Activity_CopyHero;
      
      public static const TYPE_Activity_TreasureMap:uint = CONST_SHORTCUTS.TYPE_Activity_TreasureMap;
      
      public static const TYPE_Activity_SuperHero:uint = CONST_SHORTCUTS.TYPE_Activity_SuperHero;
      
      public static const TYPE_Activity_Mall:uint = CONST_SHORTCUTS.TYPE_Activity_Mall;
      
      public static const TYPE_Activity_DailyQuest:uint = CONST_SHORTCUTS.TYPE_Activity_DailyQuest;
      
      public static const TYPE_Activity_DailyActivity:uint = CONST_SHORTCUTS.TYPE_Activity_DailyActivity;
      
      public static const TYPE_Activity_NarutoRoad:uint = CONST_SHORTCUTS.TYPE_Activity_NarutoRoad;
      
      public static const TYPE_Activity_Slave:uint = CONST_SHORTCUTS.TYPE_Activity_Slave;
      
      public static const TYPE_Activity_SevenKing:uint = CONST_SHORTCUTS.TYPE_Activity_SevenKing;
      
      public static const TYPE_Activity_CrossServerWar:uint = CONST_SHORTCUTS.TYPE_Activity_CrossServerWar;
      
      public static const TYPE_Activity_Magic:uint = CONST_SHORTCUTS.TYPE_Activity_Magic;
      
      public static const TYPE_Activity_Moutain:uint = CONST_SHORTCUTS.TYPE_Activity_Moutain;
      
      public static const TYPE_Activity_Tower:uint = CONST_SHORTCUTS.TYPE_Activity_Tower;
      
      public static const TYPE_Activity_DailyWelfare:uint = CONST_SHORTCUTS.TYPE_Activity_DailyWelfare;
      
      public static const TYPE_Activity_Palace:uint = CONST_SHORTCUTS.TYPE_Activity_Palace;
      
      public static const TYPE_Activity_NijiaStar:uint = CONST_SHORTCUTS.TYPE_Activity_NijiaStar;
      
      public static const TYPE_Activity_Ramen:uint = CONST_SHORTCUTS.TYPE_Activity_Ramen;
      
      public static const TYPE_Activity_TopOrganization:uint = CONST_SHORTCUTS.TYPE_Activity_TopOrganization;
      
      public static const TYPE_Activity_GroupBattle:uint = CONST_SHORTCUTS.TYPE_Activity_GroupBattle;
      
      public static const TYPE_Activity_Laboratory:uint = CONST_SHORTCUTS.TYPE_Activity_Laboratory;
      
      public static const TYPE_Activity_SixFairy:uint = CONST_SHORTCUTS.TYPE_Activity_SixFairy;
      
      public static const TYPE_Activity_RebirthRealm:uint = CONST_SHORTCUTS.TYPE_Activity_RebirthRealm;
      
      public static const TYPE_Activity_NijiaMystic:uint = CONST_SHORTCUTS.TYPE_Activity_NijiaMystic;
      
      public static const TYPE_Activity_NarutoHelper:uint = CONST_SHORTCUTS.TYPE_Activity_NarutoHelper;
      
      public static const TYPE_Activity_More:uint = CONST_SHORTCUTS.TYPE_Activity_More;
      
      public static const TYPE_Activity_TopTeam:uint = CONST_SHORTCUTS.TYPE_Activity_TopTeam;
      
      public static const TYPE_Activity_Choose:uint = CONST_SHORTCUTS.TYPE_Activity_Choose;
      
      public static const TYPE_Activity_NinjaRelation:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaRelation;
      
      public static const TYPE_Activity_NinjaHostel:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaHostel;
      
      public static const TYPE_Activity_BloodFete:uint = CONST_SHORTCUTS.TYPE_Activity_BloodFete;
      
      public static const TYPE_Activity_EpicEquip:uint = CONST_SHORTCUTS.TYPE_Activity_EpicEquip;
      
      public static const TYPE_Activity_Taboo:uint = CONST_SHORTCUTS.TYPE_Activity_Taboo;
      
      public static const TYPE_Activity_Awaken:uint = CONST_SHORTCUTS.TYPE_Activity_Awaken;
      
      public static const TYPE_Activity_EightDoor:uint = CONST_SHORTCUTS.TYPE_Activity_EightDoor;
      
      public static const TYPE_Activity_TransmigrationAccessory:uint = CONST_SHORTCUTS.TYPE_Activity_TransmigrationAccessory;
      
      public static const TYPE_Activity_TheWorldTree:uint = CONST_SHORTCUTS.TYPE_Activity_TheWorldTree;
      
      public static const TYPE_Activity_Undertown:uint = CONST_SHORTCUTS.TYPE_Activity_Undertown;
      
      public static const TYPE_Activity_LostShenQi:uint = CONST_SHORTCUTS.TYPE_Activity_LostShenQi;
      
      public static const TYPE_Activity_Wing:uint = CONST_SHORTCUTS.TYPE_Activity_Wing;
      
      public static const TYPE_Activity_Challenge:uint = CONST_SHORTCUTS.TYPE_Activity_Challenge;
      
      public static const TYPE_Activity_Illustrated:uint = CONST_SHORTCUTS.TYPE_Activity_Illustrated;
      
      public static const TYPE_Activity_Aline:uint = CONST_SHORTCUTS.TYPE_Activity_Aline;
      
      public static const TYPE_Activity_KingWar:uint = CONST_SHORTCUTS.TYPE_Activity_KingWar;
      
      public static const TYPE_Activity_Medal:uint = CONST_SHORTCUTS.TYPE_Activity_Medal;
      
      public static const TYPE_Activity_InviteCode:uint = CONST_SHORTCUTS.TYPE_Activity_InviteCode;
      
      public static const TYPE_Activity_WuXing:uint = CONST_SHORTCUTS.TYPE_Activity_WuXing;
      
      public static const TYPE_Activity_GlobalBattle:uint = CONST_SHORTCUTS.TYPE_Activity_GlobalBattle;
      
      public static const TYPE_Activity_Emblem:uint = CONST_SHORTCUTS.TYPE_Activity_Emblem;
      
      public static const TYPE_Activity_WorldMatch:uint = CONST_SHORTCUTS.TYPE_Activity_WorldMatch;
      
      public static const TYPE_Activity_SummonBattle:uint = CONST_SHORTCUTS.TYPE_Activity_SummonBattle;
      
      public static const TYPE_Activity_NinjaTalent:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaTalent;
      
      public static const TYPE_Activity_ChallengCamp:uint = CONST_SHORTCUTS.TYPE_Activity_ChallengCamp;
      
      public static const TYPE_Activity_GlobalBoss:uint = CONST_SHORTCUTS.TYPE_Activity_GlobalBoss;
      
      public static const TYPE_Activity_Recruit:uint = CONST_SHORTCUTS.TYPE_Activity_Recruit;
      
      public static const TYPE_Activity_CrossSlave:uint = CONST_SHORTCUTS.TYPE_Activity_CrossSlave;
      
      public static const ACTIVITYS_TYPE:Vector.<uint> = CONST_SHORTCUTS.ACTIVITYS_TYPE;
      
      public static const RESOURCE_ClassName_Activity_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Btns;
      
      protected static const COORDINATE_ActivityBtn:Vector.<int> = Vector.<int>([1,7]);
      
      protected var FWindowActivitySecondary:TWindowActivitySecondary;
      
      protected var FUIShortcut:TUIShortcut;
      
      protected var FIsEffects:Vector.<Boolean>;
      
      protected var FUnlockStates:Vector.<Boolean>;
      
      protected var FIsInitialization:Boolean;
      
      protected var FIsOpens:Vector.<Boolean>;
      
      protected var FUnlocks:TUnlocks;
      
      protected var FBounds:TBounds;
      
      protected var FCoordinate:TCoordinate;
      
      protected var FButtonStatus:Vector.<Boolean>;
      
      protected var FOnActivity:Function;
      
      protected var FOnUnlockActivityResponse:Function;
      
      public function TWindowActivity(param1:TUIComponent, param2:TUIComponent)
      {
         super(param1);
         this.FWindowActivitySecondary = new TWindowActivitySecondary(param2);
         this.FWindowActivitySecondary.OnActivitySecondary = this.ActivitySecondaryOnClick;
         this.FWindowActivitySecondary.Visible = false;
         this.FUIShortcut = new TUIShortcut(this);
         this.FUIShortcut.Capacity = ACTIVITYS_TYPE.length;
         this.FIsEffects = new Vector.<Boolean>(ACTIVITYS_TYPE);
         this.FUnlockStates = new Vector.<Boolean>(ACTIVITYS_TYPE.length);
         this.FIsOpens = new Vector.<Boolean>();
         this.FBounds = new TBounds();
         this.FButtonStatus = SLogicsCore.ButtonStatus;
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:TAnimationSequence = null;
         this.FUIShortcut.Bmp_Left = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Left);
         this.FUIShortcut.BmpData_Middle = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Middle);
         this.FUIShortcut.Bmp_Right = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Right);
         _loc5_ = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect,0);
         this.FUIShortcut.Effects = _loc5_;
         _loc2_ = int(ACTIVITYS_TYPE.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = RESOURCE_ClassName_Activity_Btns[_loc1_];
            _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject(_loc3_) as SimpleButton;
            if(_loc4_ == null)
            {
               _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject("Shortcuts_Activity_SubmitBug") as SimpleButton;
            }
            this.FUIShortcut.SetButtonByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUnlockStates[_loc1_] = false;
            this.FIsEffects[_loc1_] = false;
            this.FIsOpens[_loc1_] = true;
            if(_loc1_ == TYPE_Activity_More)
            {
               this.FIsOpens[_loc1_] = false;
            }
            this.FButtonStatus[_loc1_] = this.FUnlockStates[_loc1_] && this.FIsOpens[_loc1_];
            _loc1_++;
         }
      }
      
      protected function Resources_UILocations() : void
      {
         this.FUIShortcut.CoordinateBtn = COORDINATE_ActivityBtn;
         this.FUIShortcut.Perform_UIDispatch();
         this.InitializationActivitys();
      }
      
      protected function InitializationActivitys() : void
      {
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_More);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Arena);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_KillHeros);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Sign);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_CopyHero);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_TreasureMap);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_SuperHero);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Mall);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_DailyQuest);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_DailyActivity);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_NarutoRoad);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Slave);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_SevenKing);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_CrossServerWar);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_SubmitBug);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Magic);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Moutain);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Tower);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_DailyWelfare);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Palace);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_NijiaStar);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Ramen);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_TopOrganization);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_GroupBattle);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Laboratory);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_SixFairy);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_RebirthRealm);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_NijiaMystic);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_TopTeam);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_NarutoHelper);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Choose);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_NinjaRelation);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_NinjaHostel);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_BloodFete);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_EpicEquip);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Taboo);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Awaken);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_TransmigrationAccessory);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_EightDoor);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_TheWorldTree);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Undertown);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_LostShenQi);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Wing);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Challenge);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Illustrated);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Aline);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_KingWar);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Medal);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_InviteCode);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_WuXing);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_GlobalBattle);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Emblem);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_WorldMatch);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_SummonBattle);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_NinjaTalent);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_ChallengCamp);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_GlobalBoss);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_Recruit);
         this.FUIShortcut.SetFunctionByIndex(this.ActivityOnClick,TYPE_Activity_CrossSlave);
         this.FUIShortcut.OnBtnOver = this.ActivityOnOver;
         this.FWindowActivitySecondary.addEventListener(MouseEvent.ROLL_OVER,this.WindowActivitySecondaryOnOver);
         this.addEventListener(MouseEvent.ROLL_OUT,this.WindowActivityOnOut);
         this.FWindowActivitySecondary.addEventListener(MouseEvent.ROLL_OUT,this.WindowActivitySecondaryOnOut);
      }
      
      protected function UpdateShortcutEffect() : void
      {
         if(this.FUIShortcut.IsInitialization)
         {
            this.FUIShortcut.UpdataEffect();
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc4_:Boolean = false;
         _loc3_ = this.FUIShortcut.GetButtonByIndex(param1);
         if(!this.FIsEffects || this.FIsEffects.length == 0)
         {
            return;
         }
         this.FIsEffects[param1] = param2;
         if(!_loc3_.visible)
         {
            return;
         }
         _loc4_ = this.FUIShortcut.GetIsEffectByIndex(param1);
         if(_loc4_ != param2)
         {
            this.FUIShortcut.SetIsEffectByIndex(param2,param1);
         }
      }
      
      protected function ComponentsAlign() : void
      {
         var _loc1_:SimpleButton = null;
         if(!this.Visible)
         {
            return;
         }
         _loc1_ = this.FUIShortcut.GetButtonByIndex(TYPE_Activity_More);
         if(!_loc1_.visible)
         {
            return;
         }
         this.FCoordinate = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc1_);
         this.FCoordinate.X += this.FUIShortcut.BmpData_Middle.width / 2;
         this.FCoordinate.Y += this.Height - 18;
         if(this.FWindowActivitySecondary.ShortcutWidth > 0)
         {
            this.FWindowActivitySecondary.X = this.FCoordinate.X - this.FWindowActivitySecondary.ShortcutWidth / 2;
            this.FWindowActivitySecondary.Y = this.FCoordinate.Y;
         }
         else if(this.FWindowActivitySecondary.Visible)
         {
            this.FWindowActivitySecondary.Hide();
         }
      }
      
      protected function ActivityOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:ByteArray = null;
         _loc4_ = new ByteArray();
         if(param2 == TYPE_Activity_More)
         {
            _loc3_ = this.FWindowActivitySecondary.Visible;
            if(!_loc3_)
            {
               this.FWindowActivitySecondary.Hide();
            }
            else
            {
               this.FWindowActivitySecondary.Show();
            }
            return;
         }
         if(param2 == TYPE_Activity_Magic)
         {
            _loc4_.writeByte(0);
         }
         else if(param2 == TYPE_Activity_Moutain)
         {
            _loc4_.writeByte(1);
         }
         else if(param2 == TYPE_Activity_Laboratory)
         {
            _loc4_.writeByte(0);
         }
         else if(param2 == TYPE_Activity_SixFairy)
         {
            _loc4_.writeByte(0);
         }
         else if(param2 == TYPE_Activity_RebirthRealm)
         {
            _loc4_.writeByte(0);
         }
         if(this.FOnActivity != null)
         {
            this.FOnActivity(this,param2,_loc4_);
         }
      }
      
      protected function ActivitySecondaryOnClick(param1:Object, param2:int, param3:ByteArray = null) : void
      {
         if(this.FOnActivity != null)
         {
            this.FOnActivity(this,param2,param3);
         }
      }
      
      protected function ActivityOnOver(param1:Object, param2:int) : void
      {
         if(param2 == TYPE_Activity_More)
         {
            this.FWindowActivitySecondary.Show();
            return;
         }
         this.FWindowActivitySecondary.Hide();
      }
      
      protected function WindowActivityOnOut(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:TCoordinate = null;
         _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(this.FWindowActivitySecondary);
         this.FBounds.Assign(_loc3_);
         this.FBounds.Width = this.FWindowActivitySecondary.ShortcutWidth;
         this.FBounds.Height = this.FWindowActivitySecondary.Height + 20;
         this.FBounds.Y -= 20;
         _loc2_ = TUtilityCartisian.BoundsContainsCoordinate(this.FBounds,FUICore.MouseCoordinate);
         if(!_loc2_)
         {
            this.FWindowActivitySecondary.Hide();
         }
      }
      
      protected function WindowActivitySecondaryOnOver(param1:MouseEvent) : void
      {
         this.FWindowActivitySecondary.Show();
      }
      
      protected function WindowActivitySecondaryOnOut(param1:MouseEvent) : void
      {
         this.FWindowActivitySecondary.Hide();
      }
      
      public function get ShortcutWidth() : int
      {
         return this.FUIShortcut.Bounds.Width;
      }
      
      public function get OnActivity() : Function
      {
         return this.FOnActivity;
      }
      
      public function set OnActivity(param1:Function) : void
      {
         this.FOnActivity = param1;
      }
      
      public function get OnUnlockActivityResponse() : Function
      {
         return this.FOnUnlockActivityResponse;
      }
      
      public function set OnUnlockActivityResponse(param1:Function) : void
      {
         this.FOnUnlockActivityResponse = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.FWindowActivitySecondary.Perform_UIDispatch();
         this.FIsInitialization = true;
      }
      
      public function Update() : void
      {
         this.ComponentsAlign();
         this.FWindowActivitySecondary.Update();
         this.UpdateShortcutEffect();
      }
      
      public function UpdateShortcutsState(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:TUnlock = null;
         var _loc6_:SimpleButton = null;
         var _loc7_:TUnlocks = null;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         _loc7_ = param1 as TUnlocks;
         _loc9_ = -1;
         if(_loc7_ != null && this.FUnlocks != _loc7_)
         {
            this.FUnlocks = _loc7_;
         }
         _loc3_ = _loc7_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc7_.GetUnlockByIndex(_loc2_);
            if(_loc5_.Position == POSITION_Activity)
            {
               _loc4_ = false;
               if(_loc5_.State == TUnlock.UNLOCKSTATE_Unlocked)
               {
                  _loc4_ = true;
                  _loc8_ = this.FIsOpens[_loc5_.Localtion];
                  this.FUnlockStates[_loc5_.Localtion] = _loc4_;
                  _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc5_.Localtion);
                  this.FButtonStatus[_loc5_.Localtion] = _loc4_ && _loc8_;
                  _loc6_.visible = this.FButtonStatus[_loc5_.Localtion];
               }
            }
            _loc2_++;
         }
         _loc9_ = this.ShowShortcuts();
         if(_loc9_ > -1)
         {
            this.FWindowActivitySecondary.UpdateShortcutsState(this.FIsOpens,this.FUnlockStates,_loc9_);
            this.FUnlockStates[TYPE_Activity_More] = true;
         }
         else
         {
            this.FUnlockStates[TYPE_Activity_More] = false;
            this.FWindowActivitySecondary.SetEffects(this.FIsEffects);
         }
         this.UpdateActivityShortcuts();
         if(_loc9_ > -1)
         {
            this.ProcessorShortcutShowEffect(TYPE_Activity_More,this.CheckTypeMore());
         }
      }
      
      protected function ShowShortcuts(param1:TLobbyShortcutActivityModes = null) : int
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:SimpleButton = null;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         _loc2_ = 0;
         _loc8_ = -1;
         _loc4_ = ACTIVITYS_TYPE.length;
         _loc3_ = 1;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FUnlockStates[_loc3_];
            _loc7_ = this.FIsOpens[_loc3_];
            _loc10_ = (_loc7_) && _loc5_;
            if(_loc10_)
            {
               _loc2_++;
               if(_loc2_ > CONST_SHORTCUTS.TARGET_Index)
               {
                  _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc3_);
                  _loc6_.visible = false;
               }
               else if(_loc2_ == CONST_SHORTCUTS.TARGET_Index)
               {
                  _loc9_ = _loc3_;
               }
            }
            _loc3_++;
         }
         if(_loc2_ > CONST_SHORTCUTS.TARGET_Index)
         {
            _loc5_ = true;
            this.FIsOpens[TYPE_Activity_More] = _loc5_;
            _loc7_ = this.FIsOpens[TYPE_Activity_More];
            this.FUnlockStates[TYPE_Activity_More] = _loc5_;
            this.FButtonStatus[TYPE_Activity_More] = _loc5_ && _loc7_;
            _loc6_ = this.FUIShortcut.GetButtonByIndex(TYPE_Activity_More);
            _loc6_.visible = this.FButtonStatus[TYPE_Activity_More];
            if(param1 != null && Boolean(param1.GetShortcutModeByIndex(TYPE_Activity_More)))
            {
               _loc6_.visible = false;
            }
            _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc9_);
            _loc6_.visible = false;
            _loc8_ = _loc9_;
         }
         else if(_loc2_ == CONST_SHORTCUTS.TARGET_Index)
         {
            _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc9_);
            _loc6_.visible = true;
         }
         return _loc8_;
      }
      
      protected function UpdateActivityShortcuts(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc5_:SimpleButton = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc3_ = int(this.FUIShortcut.Capacity);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FUIShortcut.GetBmp_Middle(_loc2_);
            _loc5_ = this.FUIShortcut.GetButtonByIndex(_loc2_);
            _loc7_ = _loc5_.visible;
            _loc6_ = this.FIsEffects[_loc2_];
            _loc4_.visible = _loc7_;
            if(!_loc7_)
            {
               this.FUIShortcut.SetIsEffectByIndex(_loc7_,_loc2_);
            }
            else
            {
               this.FUIShortcut.SetIsEffectByIndex(_loc6_,_loc2_);
            }
            _loc2_++;
         }
         this.FUIShortcut.UpdateComponentsLocation();
      }
      
      public function UnlockNotification(param1:TUnlock) : void
      {
         var _loc2_:SimpleButton = null;
         var _loc3_:TCoordinate = null;
         var _loc4_:TBounds = null;
         _loc2_ = this.FUIShortcut.GetButtonByIndex(param1.Localtion);
         _loc2_.alpha = 0;
         _loc2_.visible = true;
         this.FUnlockStates[param1.Localtion] = true;
         setTimeout(this.UpdateShortcutsState,3000,this.FUnlocks);
         this.UpdateActivityShortcuts(true);
         if(this.FOnUnlockActivityResponse != null)
         {
            _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc2_);
            _loc4_ = new TBounds();
            _loc4_.Assign(_loc3_);
            _loc4_.Width = _loc2_.width;
            _loc4_.Height = _loc2_.height;
            this.FOnUnlockActivityResponse(this,_loc4_,_loc2_);
         }
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutActivityModes) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:SimpleButton = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc2_ = int(this.FUIShortcut.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = param1.GetShortcutModeByIndex(_loc3_);
            _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc3_);
            switch(_loc5_)
            {
               case TLobbyShortcutMode.SHORTCUTMODE_Show:
                  _loc7_ = true;
                  break;
               case TLobbyShortcutMode.SHORTCUTMODE_Hidden:
                  _loc7_ = false;
            }
            this.FIsOpens[_loc3_] = _loc7_;
            _loc8_ = this.FUnlockStates[_loc3_];
            if(!_loc8_)
            {
               _loc7_ = _loc8_;
            }
            _loc6_.visible = _loc7_;
            _loc3_++;
         }
         _loc4_ = this.ShowShortcuts(param1);
         if(_loc4_ > -1)
         {
            this.FWindowActivitySecondary.ShortcutsSetup(param1,this.FIsOpens,this.FIsEffects,this.FUnlockStates,_loc4_);
         }
         this.UpdateActivityShortcuts();
         if(_loc4_ > -1)
         {
            this.ProcessorShortcutShowEffect(TYPE_Activity_More,this.CheckTypeMore());
         }
      }
      
      public function ShowEffectNotification(param1:uint, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         this.ProcessorShortcutShowEffect(param1,param2);
         if(param1 > CONST_SHORTCUTS.TARGET_Index)
         {
            this.FWindowActivitySecondary.ShowEffectNotification(param1,param2);
            this.ProcessorShortcutShowEffect(TYPE_Activity_More,this.CheckTypeMore());
         }
      }
      
      protected function CheckTypeMore() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FIsEffects.length;
         _loc1_ = 10;
         while(_loc1_ < _loc2_)
         {
            if(this.FIsEffects[_loc1_] && this.FWindowActivitySecondary.GetButtonVisibleStatus(_loc1_ - CONST_SHORTCUTS.TARGET_Index - 1))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function QueryShortcutCoordinate(param1:Object, param2:uint, param3:TQueryCoordinate) : void
      {
         var _loc4_:SimpleButton = null;
         var _loc5_:TCoordinate = null;
         _loc4_ = this.FUIShortcut.GetButtonByIndex(param2);
         _loc5_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc4_);
         _loc5_.X += _loc4_.width / 2 - 12;
         _loc5_.Y += _loc4_.height / 2 - 6;
         param3.Value.Assign(_loc5_);
      }
      
      public function UpdateActivityStatus(param1:uint, param2:uint) : void
      {
         this.FIsOpens[param1] = Boolean(param2);
         this.UpdateShortcutsState(this.FUnlocks);
      }
   }
}

